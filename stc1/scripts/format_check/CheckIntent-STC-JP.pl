#!/usr/bin/perl
use strict;

##################################################
# Result Format Checking for NTCIR-9 Intent Task #
#   Please install the CharsetDetector module    #
#      developed by Mr. Qian Yu in CPAN          #
#                                                #
# This code is modified by Dr. Lifeng Shang      #
# for the STC@NTCIR-12 on Oct. 19, 2015          #
#                                                #
# Modified by R. Higashinaka                     #
# for the Japanese task 2016.2.10                #
#                                                #
##################################################
#
# README: 
#
#  Usage: perl CheckIntent.pl <ResultFile> [<FixedFile>]
#   
#  You need to place deleted_tweets_20160204.txt in the same directory.
#
#  You can download deleted_tweets_20160204.txt.bz2 from https://github.com/mynlp/stc/tree/master/taskdata
#  Then, run:
#    bzip2 -d -c deleted_tweets_20160204.txt.bz2 > deleted_tweets_20160204.txt
#  
##################################################
my $resfile;
my $error=0;
my $warning=0;

my $MaxWarning = 10;
my $MaxResDoc = 10;

if (($#ARGV < 0)||($#ARGV > 2))
{
	die "Usage: perl CheckIntent.pl <ResultFile> [<FixedFile>]\n";
}
else
{
	$resfile = $ARGV[0];
}

my %deleted = ();

open(IN,"deleted_tweets_20160204.txt") || die "ERROR: cannot find deleted_tweets_20160204.txt";
while(<IN>)
{
    chomp;
    $deleted{$_} = 1;
}
close(IN);

print "loaded deleted_tweets_20160204.txt\n";

my $TeamID;
my $SubTask;
my $Language;
my $Priority;
my $fix = 0;
my $fixedfile;

if($#ARGV == 1)
{
	$fixedfile = $ARGV[1];
	if(open(O, ">$fixedfile"))
	{
		$fix = 1;
	}else{
		die $ARGV[1]." cannot be created.\n";
	}
}

# Filename Format Checking 
if ($resfile =~ m/^(.*?)-(.*?)-R(.*?)\.txt$/)
{
	$TeamID = $1;
	$Language = $2;
	$Priority = $3;

	if (index ($TeamID, "\/") != -1)
	{
		die "Error: TeamID in Filename shouldn't contain '/'.\n";
	}
	if ($Language ne "J")
	{
		die "Error: Language in Filename should be 'J'(for Japanese).\n";
	}
	if (($Priority != 1)&&($Priority != 2)&&($Priority != 3)&&($Priority != 4)&&($Priority != 5))
	{
		die "Error: Priority in Filename should be an integer from 1 to 5.\n";
	}
}
else
{
	die "Error: Result Filename Format Error (should be teamID-language-R<priority>.txt, e.g. Huawei-J-R1.txt).\n";
	
}

my $line;
my $ucs2;
my $linenum=1;

my $pTopicID;
my $cTopicID;
my $Charset;
my $pRank;
my $cRank;
my $DocID;
my $temp1;
my $temp2;
my $temp3;


# Result Format Checking for Document Ranking Task
open RES, $resfile or die "Error: Cannot open result file.\n";

$line = <RES>;
if (!($line =~ m/<SYSDESC>(.*?)<\/SYSDESC>/))
{
	$warning++;
	die "Error: No system description in the result file.\n";
}
	
while ($line = <RES>)
{
	$linenum++;
	if ($line =~ m/^(\S+) 0 (\S+) (\S+) (\S+) (\S+)\n/)
	{
		$temp1 = $1;
		$temp2 = $2;
		$temp3 = $3;

		if ($linenum == 2)
		{
			$pTopicID = $temp1;
			$DocID = $temp2;
			$pRank = $temp3;

			if ($pRank != 1)
			{
				$warning++;
				print "Warning: Line $linenum format error (result ranking doesn't start from 1)\n";
			}

			if ($Language eq "J" && (!($pTopicID =~ m/^\d+$/)) || (!($DocID =~ m/^\d+$/)))
			{
				$warning ++;
				print "Warning: TopicID/DocID format error ($pTopicID $DocID) in Line $linenum\n";
			}

			if (defined($deleted{$DocID}))
			{
				$warning ++;
				print "Warning: deleted DocID included in Line $linenum [$DocID]\n";
			}
			
		}
		else
		{
			$cTopicID = $temp1;
			$DocID = $temp2;
			$cRank = $temp3;				
			if ($Language eq "J" && (!($pTopicID =~ m/^\d+$/)) || (!($DocID =~ m/^\d+$/)))
			{
				$warning++;
				print "Warning: TopicID/DocID format error ($cTopicID $DocID) in Line $linenum\n";
			}

			if (defined($deleted{$DocID}))
			{
				$warning ++;
				print "Warning: deleted DocID included in Line $linenum [$DocID]\n";
			}

			if (($cTopicID eq $pTopicID)&&(($cRank - $pRank) != 1))
			{
				$warning++;
				print "Warning: Line $linenum format error (result ranking doesn't follow ascending order)\n";
			}

			if (($cTopicID ne $pTopicID)&&($cRank != 1))
			{
				$warning++;
				print "Warning: Line $linenum format error (result ranking doesn't start from 1)\n";
			}

			if (($cTopicID ne $pTopicID)&&($pRank < $MaxResDoc))
			{
			        print "Notice: Less than $MaxResDoc result documents for TopicID=$cTopicID (Line $linenum).\n";
			}

			if ($cRank > $MaxResDoc)
			{
				$warning++;
				print "Warning: Too many documents for TopicID=$cTopicID (Line $linenum).\n";
			}

			$pTopicID = $cTopicID;
			$pRank = $cRank;				
		}
	}
	else
	{
		if ($line eq "\n")
		{
			next;
		}
		$warning++;
		print "Warning: Line $linenum format error in the result file.\n";
	}
}

if ($warning >= 10)
{
	die "Stop Checking: Too many warnings or errors\n";
}

close(RES);


if ($warning == 0)
{
	print "Check Complete.\n";
}


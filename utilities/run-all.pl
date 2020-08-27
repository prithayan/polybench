#!/usr/bin/perl

# Visits every directory, calls make, and then executes the benchmark
# (Designed for making sure every kernel compiles/runs after modifications)
#
# Written by Tomofumi Yuki, 01/15 2015
#

use Cwd qw();
my $DIR = Cwd::cwd()."/";
print "$DIR\n";
my $TARGET_DIR = ".";

if ($#ARGV != 0 && $#ARGV != 1) {
   printf("usage perl run-all.pl target-dir [output-file]\n");
   exit(1);
}



if ($#ARGV >= 0) {
   $TARGET_DIR = $ARGV[0];
}

my $OUTFILE = "";
if ($#ARGV == 1) {
   $OUTFILE = $ARGV[1];
}


my @categories = ('linear-algebra/blas',
                  'linear-algebra/kernels',
                  'linear-algebra/solvers',
                  'datamining',
                  'stencils',
                  'medley');
my @runApps = ('lu','ludcmp','covariance','correlation','heat-3d','seidel-2d');
#my @runApps = ('deriche');
my %filterApps = map { $_ => 1 } @runApps;  


foreach $cat (@categories) {
   my $target = $TARGET_DIR.'/'.$cat;
   my $CfgFile=$DIR."config.mk";
   my $bashRunExpFile=$DIR."utilities/runExp.sh";
   opendir DIR, $target or die "directory $target not found.\n";
   while (my $dir = readdir DIR) {
        next if ($dir=~'^\..*');
        next if (!(-d $target.'/'.$dir));

        my $kernel = $dir;
        next unless(exists($filterApps{$kernel})) ;
        #
        my $targetDir = $target.'/'.$dir;
        #my $command = "cd $targetDir; make clean; make; ./$kernel";
        my $command = "cd $targetDir; bash $bashRunExpFile $DIR $kernel $targetDir $OUTFILE  ";
        #$command .= " 2>> $OUTFILE" if ($OUTFILE ne '');
        print($command."\n");
        system($command);
   }

   closedir DIR;
}


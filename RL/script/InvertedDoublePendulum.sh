N=10
total=10000
trainTimestep=100
testEpisode=1
task="InvertedDoublePendulum-v1"
outdir="output/InvertedDoublePendulum-v1/"

#DDPG
for ((i=0;i<$N;i++))
do
  python src/main.py --model DDPG --env $task --outdir $outdir/DDPG/$i \
    --total $total --train $trainTimestep --test $testEpisode --reward_k 0.03 \
    --tfseed $i --gymseed $i --npseed $i
done

#NAF
for ((i=0;i<$N;i++))
do
  python src/main.py --model NAF --env $task --outdir $outdir/NAF/$i \
    --total $total --train $trainTimestep --test $testEpisode --reward_k 0.02 \
    --tfseed $i --gymseed $i --npseed $i
done

#ICNN
for ((i=0;i<$N;i++))
do
  python src/main.py --model ICNN --env $task --outdir $outdir/ICNN/$i \
    --total $total --train $trainTimestep --test $testEpisode --reward_k 0.01 \
    --tfseed $i --gymseed $i --npseed $i
done

#plot
python src/plot.py --runs $N --total $total --train $trainTimestep --data $outdir

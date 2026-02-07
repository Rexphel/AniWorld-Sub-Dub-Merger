#!/bin/bash
# Usage: ./merge.sh ExampleFileName Lengthofseason
# Important! Change the language string to your prefered language

template="${1::-29}"
language="German"

num_files=($(ls 2>/dev/null -Ubad1 -- "$template"* | wc -l))
half_files=$((num_files/2))

episode_count=1
while [ $episode_count -le $half_files ]; do
    season=""
    episode=""
    if  [ $episode_count -le 9 ]; then
        episode="E00$episode_count"
    elif [ $episode_count -le 99 ]; then
        episode="E0$episode_count"
    else
        episode="E$episode_count"
    fi

    season_counter=1
    if [ $episode_count -le $2 ];then
        season="S01"
    else
        while [ $((episode_count-$2*$season_counter)) -lt $2 ]; do
            ((season_counter++))
        done
        ((season_counter++))
    fi

    if  [ 9 -gt $season_counter ]; then
        season="S0$season_counter"
    else
        season="S$season_counter"
    fi

    file1="$template - $season$episode - ($language Dub).mp4"
    file2="$template - $season$episode - ($language Sub).mp4"

    mkvmerge -o "$template - $season$episode.mp4" --language -1:ger "$file1" --language -1:jpn "$file2"

    ((episode_count++))

done


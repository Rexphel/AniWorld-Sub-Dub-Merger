#!/bin/bash
# Usage: ./merge.sh Name of the Series, Number of Seasons, Language, Delete Files (0/1 Default 0)

#$1: Number of Episodes, $2: Series Name, $3: Season, $4: Language, $5: Delete Files
merge_episodes() {

    num_episodes=$1
    template="$2"
    season="$3"

    episode_count=1
    while [ $episode_count -le $num_episodes ]; do
        episode=""
        if  [ $episode_count -le 9 ]; then
            episode="E00$episode_count"
        elif [ $episode_count -le 99 ]; then
            episode="E0$episode_count"
        else
            episode="E$episode_count"
        fi

        file1="$template - $season$episode - ($4 Dub).mp4"
        file2="$template - $season$episode - ($4 Sub).mp4"

        mkvmerge -o "$template - $season$episode.mp4" --language -1:ger "$file1" --language -1:jpn "$file2"

        if [ $5 -eq 1 ];then
            rm "$file1" "$file2"
        fi

        ((episode_count++))

    done

}

#$1: Number of Movies, $2: Series Name, $3: Language, $4: Delete Files
merge_movies() {

    num_movies=$1
    template="$2"
    episode_count=1
    while [ $episode_count -le $num_movies ]; do
        episode=""
        if  [ $episode_count -le 9 ]; then
            episode="Movie 00$episode_count"
        elif [ $episode_count -le 99 ]; then
            episode="Movie 0$episode_count"
        else
            episode="Movie $episode_count"
        fi

        file1="$template - $episode - ($3 Dub).mp4"
        file2="$template - $episode - ($3 Sub).mp4"

        mkvmerge -o "$template - $episode.mp4" --language -1:ger "$file1" --language -1:jpn "$file2"

        if [ $4 -eq 1 ];then
            rm "$file1" "$file2"
        fi

        ((episode_count++))

    done


}

main() {

    num_movies=($(ls 2>/dev/null -Ubad1 -- "$1 - Movie"* | wc -l))
    if [ $num_movies -ge 2 ];then
        num_merged_movies=$((num_movies/2))
        merge_movies $num_merged_movies "$1" $3 $4
    else
        echo "No Movies found. Skip to Episodes"
    fi

    num_season=1
    while [ $num_season -le $2 ];do

        if  [ $num_season -le 9 ]; then
            season="S0$num_season"
        else
            season="S$num_season"
        fi

        num_episodes=($(ls 2>/dev/null -Ubad1 -- "$1 - $season"* | wc -l))
        if [ $num_episodes -ge 2 ];then
            num_merged_episodes=$((num_episodes/2))
            merge_episodes $num_merged_episodes "$1" "$season" $3 $4
        else
            echo "No Episodes in Season $num_season found"
        fi
        ((num_season++))

    done




}

if [ $# -eq 4 ];then
    main "$1" $2 "$3" $4
elif [ $# -eq 3 ];then
    main "$1" $2 "$3" 0
else
    echo "Wrong Input Arguments"
fi


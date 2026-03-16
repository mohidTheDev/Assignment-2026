#!/bin/bash

if ! command -v "tput" &> /dev/null; then
        echo "Error: command tput not found"
        echo "Install ncurses-bin"
        exit 1
fi

if ! command -v "shuf" &> /dev/null; then
        echo "Error: command shuf not found"
        echo "Install coreutils"
        exit 1
fi

easyWords=(
        "the" "and" "is" "to" "it"
        "run" "cat" "dog" "sad" "in"
        "with" "for" "she" "but" "do"
)

medWords=(
        "because" "quickly" "system" "create" "between"
        "always" "however" "during" "strong" "nature"
        "yellow" "people" "water" "around" "thought"
)

hardWords=(
        "rhythm" "minimum" "queue" "awkward" "pumpkin"
        "bureaucracy" "juxtapose" "knowledgeable" "zephyr" "ubiquitous"
        "knapsack" "exaggerated" "syzygy" "mnemonic" "notwithstanding"
)


colourReset="\033[0m"
colourGrey="\033[2m"
colourBoldGreen="\033[1;32m"
colourBoldRed="\033[1;31m"
colourBgRed="\033[41m"


pickUniqueWord()
{
    local -n wordArray=$1
    local -n selectedWords=$2
    local n

    while true; do
        n=$(( RANDOM % ${#wordArray[@]} ))
        if printf "%s\n" "${lastFiveIndices[@]}" | grep -q -x "$n"; then
            continue
        fi
        selectedWords+=("${wordArray[$n]}")

        if [ ${#lastFiveIndices[@]} -ge 5 ]; then
            lastFiveIndices=("${lastFiveIndices[@]:1}")
        fi
        lastFiveIndices+=("$n")

        break
    done
}




while true; do
        clear

        echo "Typing Test"
        echo ""


        easyPercent=0
        medPercent=0
        hardPercent=0
        difficulty=""

        read -p "Choose difficulty ((e)asy / (m)edium / (h)ard: " choice

        if [[ "$choice" == "e" || "$choice" == "E" ]]; then
                easyPercent=60
                medPercent=20
                hardPercent=20
                difficulty="Easy"
        elif [[ "$choice" == "m" || "$choice" == "M" ]]; then
                easyPercent=20
                medPercent=60
                hardPercent=20
                difficulty="Medium"
        else
                easyPercent=20
                medPercent=20
                hardPercent=60
                difficulty="Hard"
        fi

        timeBasedTestTime=30
        read -p "Time based Test (t) (30 seconds) ? or Completion based test (c) ?: " testType

        noOfWords=$((10 + RANDOM % 6))
        if [[ "$testType" == "t" || "$testType" == "T" ]]; then
                noOfWords=100
        fi

        noOfEasy=$(( noOfWords * easyPercent / 100 ))
        noOfMed=$(( noOfWords * medPercent / 100 ))
        noOfHard=$(( noOfWords * hardPercent / 100))

        selectedWords=()
        difficultyOrder=()
        easySelectedWords=()
        lastFiveIndices=()
        for (( i=0; i<noOfEasy; i++ )); do
                difficultyOrder+=("e")
                pickUniqueWord easyWords easySelectedWords
        done
        medSelectedWords=()
        lastFiveIndices=()
        for (( i=0; i<noOfMed; i++ )); do
                difficultyOrder+=("m")
                pickUniqueWord medWords medSelectedWords
	done
        hardSelectedWords=()
        lastFiveIndices=()
        for (( i=0; i<noOfHard; i++ )); do
                difficultyOrder+=("h")
                pickUniqueWord hardWords hardSelectedWords
        done

        difficultyOrder=($(shuf -e "${difficultyOrder[@]}"))

        ne=0
        nm=0
        nh=0
        nd=0
        while [[ $ne -lt $noOfEasy || $nm -lt $noOfMed || $nh -lt $noOfHard ]]; do
                if [[ "${difficultyOrder[nd]}" == "e" ]]; then
                        selectedWords+=("${easySelectedWords[ne]}")
                        ((ne++))
                elif [[ "${difficultyOrder[nd]}" == "m" ]]; then
                        selectedWords+=("${medSelectedWords[nm]}")
                        ((nm++))
                else
                        selectedWords+=("${hardSelectedWords[nh]}")
                        ((nh++))
                fi

                ((nd++))
        done

        targetText="${selectedWords[*]}"

        echo "-------------------------------------------------"
        echo "Time starts when you start typing"
        echo ""
        echo "Type this:"
        echo "-------------------------------------------------"
        echo -ne "\033[2m$targetText\033[0m"

        typedText=""
        targetLen=${#targetText}
        startTime=""

        noOfRows=$(( targetLen/ $(tput cols) ))

        if [ $noOfRows -gt 0 ]; then
                tput cuu $noOfRows
        fi

        tput cr

        while [ ${#typedText} -lt "$targetLen" ]; do
                currentTime=$(date +%s)
                if [ ! -z "$startTime" ]; then
                        if [[ "$testType" == "t" || "$testType" == "T" ]]; then
                                if [[ $((currentTime - startTime)) -gt $timeBasedTestTime ]]; then
                                        break
                                fi
                        fi
                        IFS= read -r -s -n 1 -t 1 char
                else
                        IFS= read -r -s -n 1 char

                        startTime=$(date +%s)
                fi


                if [[ "$char" == $'\x7f' || "$char" == $'\b' ]]; then
                        if [ ${#typedText} -gt 0 ]; then
                                typedText="${typedText%?}"

                                n=${#typedText}
                                originalChar="${targetText:$n:1}"

                                echo -ne "\b$colourGrey$originalChar$colourReset\b"
                        fi
                        continue
                fi

                if [[ -z "$char" ]]; then
                        continue
                fi

                n=${#typedText}
                targetChar="${targetText:$n:1}"

                if [[ "$char" == "$targetChar" ]]; then
                        echo -ne "$colourBoldGreen$targetChar$colourReset"
                else
                        if [[ "$char" == " " ]]; then
                                echo -ne "$colourBgRed $colourReset"
                        else
                                echo -ne "$colourBoldRed$char$colourReset"
                        fi
                fi

                typedText+="$char"
        done

        endTime=$(date +%s)
        echo ""
        echo ""

        timeTaken=$(( endTime - startTime ))

        if [ "$timeTaken" -eq 0 ]; then
                timeTaken=1
        fi

        charsTyped=${#typedText}

        targetLen=${#targetText}
        if [[ "$testType" == "t" || "$testType" == "T" ]]; then
                targetLen=$charsTyped
                timeTaken=$timeBasedTestTime
        fi

        grossWPM=$(( (charsTyped * 60) / (5 * timeTaken) ))

        typedLen=${#typedText}
        correctChars=0

        minLen=$targetLen
        if [ "$typedLen" -lt "$minLen" ]; then
                minLen=$typedLen
        fi

        for (( i=0; i<minLen; i++ )); do
                if [ "${targetText:$i:1}" == "${typedText:$i:1}" ]; then
                        ((correctChars++))
                fi
        done
        netWPM=$(( (correctChars * 60) / (5 * timeTaken) ))
        maxLen=$targetLen
        if [ "$typedLen" -gt "$maxLen" ]; then
                maxLen=$typedLen
        fi
        accuracy=$(( (correctChars * 100) / maxLen ))

        echo "-------------------------------------------------"
        echo "                    Results                      "
        echo "                   ($difficulty)                 "
        echo "-------------------------------------------------"
        printf "%-15s %4s %s\n" "Time taken:" "$timeTaken" "seconds"
        printf "%-15s %4s %s\n" "Gross WPM:" "$grossWPM" "WPM"
        printf "%-15s %4s %s\n" "Net WPM:" "$netWPM" "WPM"
        printf "%-15s %4s%%\n"  "Accuracy:" "$accuracy"
        echo "-------------------------------------------------"
        echo ""

        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$timestamp] Difficulty: $difficulty | Gross WPM: $grossWPM | Net WPM: $netWPM | Accuracy: $accuracy% | Time: $timeTaken s" >> log

        read -p "Press [Enter] to try again, or type 'q' to quit: " choice
        if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
                break
        fi
done

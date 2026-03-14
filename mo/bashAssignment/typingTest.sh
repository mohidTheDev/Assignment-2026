#!/bin/bash
sentences=(
	"Joe was pleased over our gift of quail, mink, zebra, and clever oryx."
	"Fabled reader with jaded, roving eye seized by quickened impulse to expand budget."
	"How razorback-jumping frogs can level six piqued gymnasts"
	"We climbed to the top of the mountain in just under two hours; isn't that great?"
)

while true; do
        clear
        echo "Typing Test"
        echo ""

        sentenceIndex=$(( RANDOM % ${#sentences[@]} ))
        targetText="${sentences[$sentenceIndex]}"

        echo "Type this:"
        echo "-------------------------------------------------"
        echo "$targetText"
        echo "-------------------------------------------------"
        echo ""

	echo "Time starts when you start typing"
        echo "-------------------------------------------------"
	read -n 1 -r firstChar

        startTime=$(date +%s)

        read -r remainingText

        endTime=$(date +%s)

	typedText="$firstChar$remainingText"

        timeTaken=$(( endTime - startTime ))

        charsTyped=${#typedText}
        speed=$(( (charsTyped * 60) / (5 * timeTaken) ))

        targetLen=${#targetText}
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

        maxLen=$targetLen
        if [ "$typedLen" -gt "$maxLen" ]; then
                maxLen=$typedLen
        fi
        accuracy=$(( (correctChars * 100) / maxLen ))

        echo "-------------------------------------------------"
        echo "                    Results                      "
        echo "-------------------------------------------------"
        echo "Time taken: $timeTaken seconds"
        echo "Speed:      $speed WPM"
        echo "Accuracy:   $accuracy%"
        echo "-------------------------------------------------"
        echo ""

	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	echo "[$timestamp] WPM: $speed | Accuracy: $accuracy% | Time: $timeTaken s" >> log

        read -p "Press [Enter] to try again, or type 'q' to quit: " choice
        if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
                break
        fi
done

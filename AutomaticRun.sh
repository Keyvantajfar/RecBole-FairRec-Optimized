#!/bin/bash

MODEL=("ItemKNN" "PFCN_DMF" "PFCN_biasedMF" "NFCF" "FOCF" "FairGo_PMF" "FairGo_GCN" "PFCN_PMF" "NGCF" "SGL" "LightGCN" "DMF" "NeuMF" "NNCF" "DGCF")
CONFIG=("ML,ml-1M" "LFM,LastFM-100K" "BR,BookRec-100K")

LOG_DIR="$HOME/work/code-results/"
mkdir -p "$LOG_DIR"

for config in ${CONFIG[@]}; do
    IFS=',' read -r -a config_arr <<< "$config"
    
    for model in ${MODEL[@]}; do
        # --- Define Log File Names ---
        timestamp=$(date +'%H%M')
        base_log_name="${LOG_DIR}Run_${timestamp}_${model}-${config_arr[1]}"
        
        # Final log file for SUCCESSFUL runs
        success_log_file="${base_log_name}.log"
        # Log file for FAILED runs
        error_log_file="${base_log_name}.ERROR.log"
        # Temporary file to capture all output
        temp_log_file="${base_log_name}.temp.log"

        # Start timer
        start=$(date +%s)
        
        if [[ "$@" == *-r* ]] || [[ "$@" == *--resume* ]]; then
            echo "# NOTE: running in resume mode, only evaluating"
            python3 resume_run_recbole.py --model=${model} --config=Configuration${config_arr[0]}.yaml --dataset=${config_arr[1]} > "${temp_log_file}" 2>&1 &
        else
            echo "# NOTE: running in FULL training mode."
            python3 run_recbole.py --model=${model} --config=Configuration${config_arr[0]}.yaml --dataset=${config_arr[1]} > "${temp_log_file}" 2>&1 &
        fi
        
        pid=$!
        
        echo -n "Running $model-${config_arr[1]}..."
        
        while ps -p $pid > /dev/null; do
            echo -n "."
            sleep 1
        done
        
        wait $pid
        exit_code=$?
        
        # Calculate duration
        end=$(date +%s)
        duration=$((end - start))
        time_taken=$(printf "%02d:%02d" $((duration / 60)) $((duration % 60)))
        
        echo "" # Newline after dots
        
        # --- User-Friendly Log Handling ---
        # Check if the command failed OR finished suspiciously fast (e.g., < 5 seconds)
        if [ $exit_code -ne 0 ] || [ $duration -lt 5 ]; then
            # FAILURE CASE
            echo "!! JOB FAILED ($time_taken). Full error log saved to:"
            echo "   ${error_log_file}"
            # Move the temp log to the final ERROR log location
            mv "${temp_log_file}" "${error_log_file}"
        else
            # SUCCESS CASE
            echo "Job finished successfully ($time_taken)."
            # Create the truncated 20-line log from the temp file
            tail -n 20 "${temp_log_file}" > "${success_log_file}"
            # Clean up the full temporary log
            rm "${temp_log_file}"
            echo "Results saved to: ${success_log_file}"
        fi
        
        echo "------------------------------------------------------"
        sleep 1
    done
done
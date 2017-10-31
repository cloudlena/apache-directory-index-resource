#!/bin/bash

function compare_versions() {
  # Split version numbers into parts
  IFS='.' read -r -a split_1 <<< "$1"
  IFS='.' read -r -a split_2 <<< "$2"

  # Find out which version number has more parts
  loop_arr=
  if [ "${#split_1[@]}" -ge "${#split_2[@]}" ]; then
    loop_arr=("${split_1[@]}")
  else
    loop_arr=("${split_2[@]}")
  fi

  # Loop over parts and find larger version number
  for index in "${!loop_arr[@]}"; do
    num_1=${split_1[index]}
    if [ -z "${num_1}" ]; then
      num_1=0
    fi
    num_2=${split_2[index]}
    if [ -z "${num_2}" ]; then
      num_2=0
    fi

    # If parts are the same, continue with the next pair
    if [ "${num_1}" == "${num_2}" ]; then
      continue
    fi

    # Handle *-alpha, *-beta and *-rc
    if [[ "${num_1}" == *'-'* && "${num_2}" == *'-'* ]]; then
      if [[ "${num_1}" == *'-alpha'* ]]; then
        echo 2
        return
      elif [[ "${num_2}" == *'-alpha'* ]]; then
        echo 1
        return
      elif [[ "${num_1}" ==  *'-beta'* ]]; then
        echo 2
        return
      else
        echo 1
        return
      fi
    elif [[ "${num_1}" == *'-'* ]]; then
      echo 2
      return
    elif [[ "${num_2}" == *'-'* ]]; then
      echo 1
      return
    fi

    # If the two parts are just numbers, compare them directly
    if [ "${num_1}" -gt "${num_2}" ]; then
      echo 1
      return
    else
      echo 2
      return
    fi
  done

  # No difference identified => versions are equal
  echo 0
}

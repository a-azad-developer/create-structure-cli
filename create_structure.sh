#!/usr/bin/env bash

# Simpler but more reliable approach using indentation levels

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "  -f <file>     Read structure from file"
    echo "  -s <string>   Read structure from string"
    echo "  -i            Interactive mode"
    echo "  -p <path>     Base path (default: current directory)"
    echo "  -v            Verbose output"
    echo "  -h            Show this help"
    exit 1
}

# Clean and parse the structure
parse_and_create() {
    local input="$1"
    local base_path="${2:-.}"
    local verbose="${3:-false}"
    
    cd "$base_path" 2>/dev/null || mkdir -p "$base_path" && cd "$base_path"
    
    # Store parent-child relationships
    declare -A parents
    declare -A items
    local current_parent=""
    local root_items=()
    
    # First pass: determine the structure
    local line_num=0
    local last_depth=0
    local parent_stack=()
    local depth_stack=()
    
    while IFS= read -r line; do
        ((line_num++))
        [[ -z "$(echo "$line" | tr -d '[:space:]')" ]] && continue
        
        # Count indentation level
        local prefix=$(echo "$line" | sed -E 's/^([[:space:]]*).*/\1/')
        local depth=0
        
        # Count the number of spaces
        local space_count=${#prefix}
        
        # Count tree characters in the line
        local tree_chars=$(echo "$line" | grep -o '[├└│]' | wc -l)
        
        # Calculate depth based on tree characters
        if [[ $tree_chars -gt 0 ]]; then
            depth=$tree_chars
        else
            # If no tree chars, use space count
            depth=$((space_count / 4))
        fi
        
        # Clean the item name
        local item_name=$(echo "$line" | sed 's/^[├─│└ ]*//' | sed 's/^[[:space:]]*//')
        [[ -z "$item_name" ]] && continue
        
        # Store the item
        items["$line_num"]="$item_name"
        
        # Determine parent
        if [[ $depth -eq 0 ]]; then
            # Root level
            root_items+=("$line_num")
            parents["$line_num"]=""
            parent_stack=("$line_num")
            depth_stack=($depth)
        else
            # Find the parent (last item with smaller depth)
            local parent_found=false
            for ((i=line_num-1; i>=1; i--)); do
                if [[ -n "${items[$i]}" ]]; then
                    local parent_depth=0
                    # Calculate parent depth
                    local parent_line=$(sed -n "${i}p" <<< "$input")
                    local parent_prefix=$(echo "$parent_line" | sed -E 's/^([[:space:]]*).*/\1/')
                    local parent_tree=$(echo "$parent_line" | grep -o '[├└│]' | wc -l)
                    if [[ $parent_tree -gt 0 ]]; then
                        parent_depth=$parent_tree
                    else
                        parent_depth=$((${#parent_prefix} / 4))
                    fi
                    
                    if [[ $parent_depth -lt $depth ]]; then
                        parents["$line_num"]="$i"
                        parent_found=true
                        break
                    fi
                fi
            done
            
            if [[ "$parent_found" == false ]]; then
                parents["$line_num"]=""
                root_items+=("$line_num")
            fi
        fi
        
    done <<< "$input"
    
    # Second pass: create the structure
    for key in "${!items[@]}"; do
        local item="${items[$key]}"
        local parent="${parents[$key]}"
        
        # Build full path
        local full_path=""
        if [[ -n "$parent" ]]; then
            # Build path from parent
            local current=$parent
            local path_parts=()
            while [[ -n "$current" ]]; do
                path_parts=("${items[$current]}" "${path_parts[@]}")
                current="${parents[$current]}"
            done
            full_path=$(IFS=/; echo "${path_parts[*]}")
        fi
        
        # Create the item
        if [[ "$item" == */ ]]; then
            # Directory
            local dir_name="${item%/}"
            if [[ -n "$full_path" ]]; then
                mkdir -p "$full_path/$dir_name"
                [[ "$verbose" == "true" ]] && echo "Creating directory: $full_path/$dir_name/"
            else
                mkdir -p "$dir_name"
                [[ "$verbose" == "true" ]] && echo "Creating directory: $dir_name/"
            fi
        else
            # File
            if [[ -n "$full_path" ]]; then
                mkdir -p "$full_path"
                touch "$full_path/$item"
                [[ "$verbose" == "true" ]] && echo "Creating file: $full_path/$item"
            else
                # Check if file path contains directory
                local file_dir=$(dirname "$item")
                if [[ "$file_dir" != "." ]]; then
                    mkdir -p "$file_dir"
                fi
                touch "$item"
                [[ "$verbose" == "true" ]] && echo "Creating file: $item"
            fi
        fi
    done
    
    echo -e "\n✓ Structure created successfully!"
}

# Main script
VERBOSE=false
BASE_PATH="."
INPUT=""
INTERACTIVE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -f) INPUT=$(cat "$2"); shift 2 ;;
        -s) INPUT="$2"; shift 2 ;;
        -i) INTERACTIVE=true; shift ;;
        -p) BASE_PATH="$2"; shift 2 ;;
        -v) VERBOSE=true; shift ;;
        -h) show_usage ;;
        *) echo "Unknown option"; show_usage ;;
    esac
done

if [[ "$INTERACTIVE" == true ]]; then
    echo "Paste your structure and press Ctrl+D:"
    INPUT=$(cat)
fi

if [[ -z "$INPUT" ]]; then
    echo "Error: No input provided"
    show_usage
fi

parse_and_create "$INPUT" "$BASE_PATH" "$VERBOSE"
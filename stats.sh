#!/bin/sh

collect_manual() {
    key="$1"
    shift
    size=$(wc --bytes --total=only "$@")
    jq '{$key: {size: $size, files: $ARGS.positional}}' --null-input --argjson size "$size" --arg key "$key" --args "$@"
}

if command -v github-linguist >/dev/null; then
    LINGUIST='github-linguist'
else
    if ! docker image inspect linguist:latest 2>/dev/null >/dev/null; then
        echo 'github-linguist not in PATH and not built as a docker image. Install it via'
        echo 'gem install github-linguist'
        echo 'or build the docker image via'
        echo 'TEMP_DIR=$(mktemp -d)'
        echo 'git clone --depth 1 "https://github.com/github-linguist/linguist.git" $TEMP_DIR'
        echo 'pushd $TEMP_DIR'
        echo 'docker build -t linguist:latest .'
        echo 'popd'

        exit 1
    fi
    LINGUIST="docker run --rm -v $(pwd):$(pwd) -w $(pwd) --user $(id -u) -t linguist github-linguist"
fi

BC=$(collect_manual bc -- **/*.bc)

$LINGUIST --json --breakdown |
    jq -r \
        '(. + ($ARGS.positional | add))
        | (map(.size) | add) as $total_size
        | map_values(
            {
                size,
                percentage:
                    (100 * .size/$total_size)
                    | tostring
                    | match("\\d*\\.\\d\\d")
                    | .string,
                day: .files[0] | match("dec0?(\\d+)") | .captures[0].string | tonumber
            }
        )
        | to_entries
        | sort_by(.value.day)
        | map("|\(.value.day) | \($renamed[0][.key] // .key) | \(.value.percentage)%|")
        | ["|Day | Language | Share of code |", "| --- | --- | --- | --- |"] + .
        | .[]
        ' \
         --slurpfile "renamed" "languages.json" \
        --jsonargs "$BC"|
    prettier --parser markdown

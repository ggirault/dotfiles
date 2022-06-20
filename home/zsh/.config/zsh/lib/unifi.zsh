function logunifijson() {
  ssh unifi "tail -f /var/log/messages" | \
    jq --unbuffered -R '. | rtrimstr(" ") | split(": ") | {date: (.[0] | split(" ") | .[0:3] | join(" "))} + (.[1] | capture("\\[.+\\] \\[(?<rule>.*)\\].*")) + ((.[1] | capture("\\[.+\\] (?<rest>.*)") | .rest | split(" ") | map(select(startswith("[") == fal
se) | split("=") | {(.[0]): .[1]})) | (reduce .[] as $item ({}; . + $item)))'
}

function logunifi() {
  logunifijson | jq --unbuffered -r '"\(.date) - \(.rule)\tIN=\(.IN)  \t\(.PROTO)\tSRC=\(.SRC)@\(.SPT)\tDST=\(.DST)@\(.DPT)\tLEN=\(.LEN)\t"'
}

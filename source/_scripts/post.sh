NOW=$(date +'%Y-%m-%d %T')

lowercase_remove_whitespace()
{
  echo "$@" | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g'
}
filename=$(lowercase_remove_whitespace $3)
template="date: $NOW\ncategory: $2\ntitle: $3\ntags: []\nauthor: taoalpha\n---"

if [[ $1 -eq "new" ]]; then
  echo $template > "source/_posts/$2/$filename.md"
  echo "Your new post is ready for you at: source/_posts/$2/$filename.md"
fi
# This script should download the file specified in the first argument ($1),
# place it in the directory specified in the second argument ($2),
# and *optionally*:
# - uncompress the downloaded file with gunzip if the third
#   argument ($3) contains the word "yes"
# - filter the sequences based on a word contained in their header lines:
#   sequences containing the specified word in their header should be **excluded**
#
# Example of the desired filtering:
#
#   > this is my sequence
#   CACTATGGGAGGACATTATAC
#   > this is my second sequence
#   CACTATGGGAGGGAGAGGAGA
#   > this is another sequence
#   CCAGGATTTACAGACTTTAAA
#
#   If $4 == "another" only the **first two sequence** should be output

#Verificar que el archivo no esta vacio:
if ["$#" -lt 2 ] then
	echo "Usage: $0 <url> <output_directory> [yes/no] [filter_keyboard]"

url = ["$1"]
output_directory = ["$2"]
uncompress = ["$3"]
filter_keyboard=["$4"]

#Create directory if it doesnt exist
mkdir -p "output_directory"

#Download the file:
wget -o   "output_directory/$(basename= "$url")" "$url"

#uncompress

if ["uncompress" == "yes"]; then
	gunzip "output_directory/$(basename= "$url")" 
fi

#Filter

if [ -n "filter_keyboard"] ; then
	grep "filter_keyboard" "$output_directory/$(basename= "$url")" > "output_directory/filtered_$(basename= "$url")"
fi


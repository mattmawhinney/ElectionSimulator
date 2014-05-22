array = ["Joe Smith, Liberal", "Mike Suarez, Conservative", "Lorenzo Gamio, Progressive", "Joe Garcia, Republican", "Elaine Kagan, Democrat", "Mike Koch, Republican"]

name = "Joe Smit"

p array.map {|list_item| list_item[0..name.length-1] == name }.include? true
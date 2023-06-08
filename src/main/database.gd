var SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var PATH = "res://data/data/data.db"
var GDPATH = "res://data/generatedData/generatedData.db"

var generatedDataPath = "res://data/generatedData/generatedData.db"
#res://.idea/data/generatedData/generatedData.db

func openDb(path:String):
	db = SQLite.new()
	db.path = path
	db.open_db()

	return db



func test(array:Array):
	print(array)
	var bytedArr = PoolByteArray(array)
	
	
	db = openDb(GDPATH)
	var tableName = "sphere"
	var tableDicctionary = Dictionary()

	tableDicctionary["id"] = {
		"data_type": "text",
		"unique": true,
		"primary_key": true
	}

	tableDicctionary["points"] = {
		"data_type": "blob"
	}

	db.create_table(tableName,tableDicctionary)
	db.insert_row(tableName, {
		"id":"asd",
		"value":bytedArr
	})
	# db.insert_rows()

	db.close_db()




func testssss(points: Array):
	var bytedPoints = PoolByteArray(points)


	print("funtion test")
	db = SQLite.new()
	db.path = generatedDataPath
	db.open_db()

	var tableName = "sphere"
	var tableDicctionary = Dictionary()

	tableDicctionary["id"] = {
		"data_type": "text",
		"unique": true,
		"primary_key": true
	}

	tableDicctionary["points"] = {
		"data_type": "blob"
	}

	db.create_table(tableName,tableDicctionary)
	db.insert_row(tableName, {
		"id":"asd",
		"value":bytedPoints
	})
	# db.insert_rows()

	db.close_db()

func test2():
	db = SQLite.new()
	db.path = generatedDataPath
	db.open_db()

	var selectedRow = db.select_rows("sphere","id = asd",["value"])
	print(selectedRow)



	db.close_db()
	return selectedRow


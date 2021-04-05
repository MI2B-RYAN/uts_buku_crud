class Note {

	int _id;
	String _judul;
	String _deskripsi;
	String _tanggal;
	int _priority;

	Note(this._judul, this._tanggal, this._priority, [this._deskripsi]);

	Note.withId(this._id, this._judul, this._tanggal, this._priority, [this._deskripsi]);

	int get id => _id;

	String get judul => _judul;

	String get deskripsi => _deskripsi;

	int get priority => _priority;

	String get tanggal => _tanggal;

	set judul(String newjudul) {
		if (newjudul.length <= 255) {
			this._judul = newjudul;
		}
	}

	set deskripsi(String newdeskripsi) {
		if (newdeskripsi.length <= 255) {
			this._deskripsi = newdeskripsi;
		}
	}

	set priority(int newPriority) {
		if (newPriority >= 1 && newPriority <= 2) {
			this._priority = newPriority;
		}
	}

	set tanggal(String newtanggal) {
		this._tanggal = newtanggal;
	}

	
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['judul'] = _judul;
		map['deskripsi'] = _deskripsi;
		map['priority'] = _priority;
		map['tanggal'] = _tanggal;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._judul = map['judul'];
		this._deskripsi = map['deskripsi'];
		this._priority = map['priority'];
		this._tanggal = map['tanggal'];
	}
}









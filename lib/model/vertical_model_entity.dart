class VerticalModelEntity {
	String msg;
	VerticalModelRes res;
	int code;

	VerticalModelEntity({this.msg, this.res, this.code});

	VerticalModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		res = json['res'] != null ? new VerticalModelRes.fromJson(json['res']) : null;
		code = json['code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		if (this.res != null) {
      data['res'] = this.res.toJson();
    }
		data['code'] = this.code;
		return data;
	}
}

class VerticalModelRes {
	List<VerticalModelResVertical> vertical;

	VerticalModelRes({this.vertical});

	VerticalModelRes.fromJson(Map<String, dynamic> json) {
		if (json['vertical'] != null) {
			vertical = new List<VerticalModelResVertical>();(json['vertical'] as List).forEach((v) { vertical.add(new VerticalModelResVertical.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.vertical != null) {
      data['vertical'] =  this.vertical.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class VerticalModelResVertical {
	String preview;
	String img;
	double atime;
	String thumb;
	String rule;
	int ncos;
	String store;
	List<Null> url;
	bool cr;
	int favs;
	int rank;
	String wp;
	bool xr;
	List<Null> tag;
	String id;
	int views;
	String desc;
	List<String> cid;

	VerticalModelResVertical({this.preview, this.img, this.atime, this.thumb, this.rule, this.ncos, this.store, this.url, this.cr, this.favs, this.rank, this.wp, this.xr, this.tag, this.id, this.views, this.desc, this.cid});

	VerticalModelResVertical.fromJson(Map<String, dynamic> json) {
		preview = json['preview'];
		img = json['img'];
		atime = json['atime'];
		thumb = json['thumb'];
		rule = json['rule'];
		ncos = json['ncos'];
		store = json['store'];
		if (json['url'] != null) {
			url = new List<Null>();
		}
		cr = json['cr'];
		favs = json['favs'];
		rank = json['rank'];
		wp = json['wp'];
		xr = json['xr'];
		if (json['tag'] != null) {
			tag = new List<Null>();
		}
		id = json['id'];
		views = json['views'];
		desc = json['desc'];
		cid = json['cid']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['preview'] = this.preview;
		data['img'] = this.img;
		data['atime'] = this.atime;
		data['thumb'] = this.thumb;
		data['rule'] = this.rule;
		data['ncos'] = this.ncos;
		data['store'] = this.store;
		if (this.url != null) {
      data['url'] =  [];
    }
		data['cr'] = this.cr;
		data['favs'] = this.favs;
		data['rank'] = this.rank;
		data['wp'] = this.wp;
		data['xr'] = this.xr;
		if (this.tag != null) {
      data['tag'] =  [];
    }
		data['id'] = this.id;
		data['views'] = this.views;
		data['desc'] = this.desc;
		data['cid'] = this.cid;
		return data;
	}
}

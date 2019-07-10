class RecommendModelEntity {
	String msg;
	RecommendModelRes res;
	int code;

	RecommendModelEntity({this.msg, this.res, this.code});

	RecommendModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		res = json['res'] != null ? new RecommendModelRes.fromJson(json['res']) : null;
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

class RecommendModelRes {
	List<RecommandModelResWallpaper> wallpaper;
	RecommendModelResAlert alert;
	List<RecommandModelResHomepage> homepage;

	RecommendModelRes({this.wallpaper, this.alert, this.homepage});

	RecommendModelRes.fromJson(Map<String, dynamic> json) {
		if (json['wallpaper'] != null) {
			wallpaper = new List<RecommandModelResWallpaper>();(json['wallpaper'] as List).forEach((v) { wallpaper.add(new RecommandModelResWallpaper.fromJson(v)); });
		}
		alert = json['alert'] != null ? new RecommendModelResAlert.fromJson(json['alert']) : null;
		if (json['homepage'] != null) {
			homepage = new List<RecommandModelResHomepage>();(json['homepage'] as List).forEach((v) { homepage.add(new RecommandModelResHomepage.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.wallpaper != null) {
      data['wallpaper'] =  this.wallpaper.map((v) => v.toJson()).toList();
    }
		if (this.alert != null) {
      data['alert'] = this.alert.toJson();
    }
		if (this.homepage != null) {
      data['homepage'] =  this.homepage.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class RecommandModelResWallpaper {
	String preview;
	String img;
	double atime;
	String thumb;
	String rule;
	String sourceType;
	int ncos;
	String store;
	String type;
	List<Null> url;
	bool cr;
	int favs;
	int rank;
	String wp;
	bool xr;
	String ruleNew;
	List<String> tag;
	String id;
	int views;
	List<String> cid;
	String desc;

	RecommandModelResWallpaper({this.preview, this.img, this.atime, this.thumb, this.rule, this.sourceType, this.ncos, this.store, this.type, this.url, this.cr, this.favs, this.rank, this.wp, this.xr, this.ruleNew, this.tag, this.id, this.views, this.cid, this.desc});

	RecommandModelResWallpaper.fromJson(Map<String, dynamic> json) {
		preview = json['preview'];
		img = json['img'];
		atime = json['atime'];
		thumb = json['thumb'];
		rule = json['rule'];
		sourceType = json['source_type'];
		ncos = json['ncos'];
		store = json['store'];
		type = json['type'];
		if (json['url'] != null) {
			url = new List<Null>();
		}
		cr = json['cr'];
		favs = json['favs'];
		rank = json['rank'];
		wp = json['wp'];
		xr = json['xr'];
		ruleNew = json['rule_new'];
		tag = json['tag']?.cast<String>();
		id = json['id'];
		views = json['views'];
		cid = json['cid']?.cast<String>();
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['preview'] = this.preview;
		data['img'] = this.img;
		data['atime'] = this.atime;
		data['thumb'] = this.thumb;
		data['rule'] = this.rule;
		data['source_type'] = this.sourceType;
		data['ncos'] = this.ncos;
		data['store'] = this.store;
		data['type'] = this.type;
		if (this.url != null) {
      data['url'] =  [];
    }
		data['cr'] = this.cr;
		data['favs'] = this.favs;
		data['rank'] = this.rank;
		data['wp'] = this.wp;
		data['xr'] = this.xr;
		data['rule_new'] = this.ruleNew;
		data['tag'] = this.tag;
		data['id'] = this.id;
		data['views'] = this.views;
		data['cid'] = this.cid;
		data['desc'] = this.desc;
		return data;
	}
}

class RecommendModelResAlert {
	String msg;

	RecommendModelResAlert({this.msg});

	RecommendModelResAlert.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		return data;
	}
}

class RecommandModelResHomepage {
	double stime;
	String hometype;
	int type;
	String title;
	List<RecommandModelResHomepageItems> items;

	RecommandModelResHomepage({this.stime, this.hometype, this.type, this.title, this.items});

	RecommandModelResHomepage.fromJson(Map<String, dynamic> json) {
		stime = json['stime'];
		hometype = json['hometype'];
		type = json['type'];
		title = json['title'];
		if (json['items'] != null) {
			items = new List<RecommandModelResHomepageItems>();(json['items'] as List).forEach((v) { items.add(new RecommandModelResHomepageItems.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['stime'] = this.stime;
		data['hometype'] = this.hometype;
		data['type'] = this.type;
		data['title'] = this.title;
		if (this.items != null) {
      data['items'] =  this.items.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class RecommandModelResHomepageItems {
	int code;
	double atime;
	String name;
	List<Null> force;
	String sId;
	String id;
	String title;
	String fnotice;
	String url;
	String notice;

	RecommandModelResHomepageItems({this.code, this.atime, this.name, this.force, this.sId, this.id, this.title, this.fnotice, this.url, this.notice});

	RecommandModelResHomepageItems.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		atime = json['atime'];
		name = json['name'];
		if (json['force'] != null) {
			force = new List<Null>();
		}
		sId = json['_id'];
		id = json['id'];
		title = json['title'];
		fnotice = json['fnotice'];
		url = json['url'];
		notice = json['notice'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['atime'] = this.atime;
		data['name'] = this.name;
		if (this.force != null) {
      data['force'] =  [];
    }
		data['_id'] = this.sId;
		data['id'] = this.id;
		data['title'] = this.title;
		data['fnotice'] = this.fnotice;
		data['url'] = this.url;
		data['notice'] = this.notice;
		return data;
	}
}

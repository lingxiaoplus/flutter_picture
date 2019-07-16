class BannerModelEntity {
	String msg;
	BannerModelRes res;
	int code;

	BannerModelEntity({this.msg, this.res, this.code});

	BannerModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		res = json['res'] != null ? new BannerModelRes.fromJson(json['res']) : null;
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

class BannerModelRes {
	List<BannerModelResWallpaper> wallpaper;

	BannerModelRes({this.wallpaper});

	BannerModelRes.fromJson(Map<String, dynamic> json) {
		if (json['wallpaper'] != null) {
			wallpaper = new List<BannerModelResWallpaper>();(json['wallpaper'] as List).forEach((v) { wallpaper.add(new BannerModelResWallpaper.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.wallpaper != null) {
      data['wallpaper'] =  this.wallpaper.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class BannerModelResWallpaper {
	String preview;
	String img;
	double atime;
	String thumb;
	int ncos;
	String store;
	List<Null> url;
	bool cr;
	int favs;
	int rank;
	String wp;
	bool xr;
	List<String> tag;
	String id;
	int views;
	String desc;
	List<String> cid;

	BannerModelResWallpaper({this.preview, this.img, this.atime, this.thumb, this.ncos, this.store, this.url, this.cr, this.favs, this.rank, this.wp, this.xr, this.tag, this.id, this.views, this.desc, this.cid});

	BannerModelResWallpaper.fromJson(Map<String, dynamic> json) {
		preview = json['preview'];
		img = json['img'];
		atime = json['atime'];
		thumb = json['thumb'];
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
		tag = json['tag']?.cast<String>();
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
		data['tag'] = this.tag;
		data['id'] = this.id;
		data['views'] = this.views;
		data['desc'] = this.desc;
		data['cid'] = this.cid;
		return data;
	}
}

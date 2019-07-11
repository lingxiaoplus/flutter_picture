class SpecialModelEntity {
	String msg;
	SpecialModelRes res;
	int code;

	SpecialModelEntity({this.msg, this.res, this.code});

	SpecialModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		res = json['res'] != null ? new SpecialModelRes.fromJson(json['res']) : null;
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

class SpecialModelRes {
	List<SpecialModelResAlbum> album;
	List<SpecialModelResBanner> banner;

	SpecialModelRes({this.album, this.banner});

	SpecialModelRes.fromJson(Map<String, dynamic> json) {
		if (json['album'] != null) {
			album = new List<SpecialModelResAlbum>();(json['album'] as List).forEach((v) { album.add(new SpecialModelResAlbum.fromJson(v)); });
		}
		if (json['banner'] != null) {
			banner = new List<SpecialModelResBanner>();(json['banner'] as List).forEach((v) { banner.add(new SpecialModelResBanner.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.album != null) {
      data['album'] =  this.album.map((v) => v.toJson()).toList();
    }
		if (this.banner != null) {
      data['banner'] =  this.banner.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SpecialModelResAlbum {
	double atime;
	String subname;
	int type;
	List<SpecialModelResAlbumUrl> url;
	String cover;
	String ename;
	int top;
	int favs;
	String nickname;
	String name;
	bool isfeed;
	String lcover;
	List<Null> tag;
	String id;
	int sn;
	SpecialModelResAlbumUser user;
	String status;
	String desc;

	SpecialModelResAlbum({this.atime, this.subname, this.type, this.url, this.cover, this.ename, this.top, this.favs, this.nickname, this.name, this.isfeed, this.lcover, this.tag, this.id, this.sn, this.user, this.status, this.desc});

	SpecialModelResAlbum.fromJson(Map<String, dynamic> json) {
		atime = json['atime'];
		subname = json['subname'];
		type = json['type'];
		if (json['url'] != null) {
			url = new List<SpecialModelResAlbumUrl>();(json['url'] as List).forEach((v) { url.add(new SpecialModelResAlbumUrl.fromJson(v)); });
		}
		cover = json['cover'];
		ename = json['ename'];
		top = json['top'];
		favs = json['favs'];
		nickname = json['nickname'];
		name = json['name'];
		isfeed = json['isfeed'];
		lcover = json['lcover'];
		if (json['tag'] != null) {
			tag = new List<Null>();
		}
		id = json['id'];
		sn = json['sn'];
		user = json['user'] != null ? new SpecialModelResAlbumUser.fromJson(json['user']) : null;
		status = json['status'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['atime'] = this.atime;
		data['subname'] = this.subname;
		data['type'] = this.type;
		if (this.url != null) {
      data['url'] =  this.url.map((v) => v.toJson()).toList();
    }
		data['cover'] = this.cover;
		data['ename'] = this.ename;
		data['top'] = this.top;
		data['favs'] = this.favs;
		data['nickname'] = this.nickname;
		data['name'] = this.name;
		data['isfeed'] = this.isfeed;
		data['lcover'] = this.lcover;
		if (this.tag != null) {
      data['tag'] =  [];
    }
		data['id'] = this.id;
		data['sn'] = this.sn;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['status'] = this.status;
		data['desc'] = this.desc;
		return data;
	}
}

class SpecialModelResAlbumUrl {
	String name;
	String target;

	SpecialModelResAlbumUrl({this.name, this.target});

	SpecialModelResAlbumUrl.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		target = json['target'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['target'] = this.target;
		return data;
	}
}

class SpecialModelResAlbumUser {
	int follower;
	int gender;
	double viptime;
	String gcid;
	int following;
	String name;
	String avatar;
	String id;
	bool isvip;

	SpecialModelResAlbumUser({this.follower, this.gender, this.viptime, this.gcid, this.following, this.name, this.avatar, this.id, this.isvip});

	SpecialModelResAlbumUser.fromJson(Map<String, dynamic> json) {
		follower = json['follower'];
		gender = json['gender'];
		viptime = json['viptime'];
		gcid = json['gcid'];
		following = json['following'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
		isvip = json['isvip'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['follower'] = this.follower;
		data['gender'] = this.gender;
		data['viptime'] = this.viptime;
		data['gcid'] = this.gcid;
		data['following'] = this.following;
		data['name'] = this.name;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		data['isvip'] = this.isvip;
		return data;
	}
}

class SpecialModelResBanner {
	String img;
	String newThumb;
	double atime;
	double offtm;
	String newImg;
	String thumb;
	int module;
	String reco;
	dynamic oid;
	double ontm;
	int type;
	String target;
	List<Null> market;
	String uid;
	String sId;
	String id;
	SpecialModelResBannerValue value;
	String desc;

	SpecialModelResBanner({this.img, this.newThumb, this.atime, this.offtm, this.newImg, this.thumb, this.module, this.reco, this.oid, this.ontm, this.type, this.target, this.market, this.uid, this.sId, this.id, this.value, this.desc});

	SpecialModelResBanner.fromJson(Map<String, dynamic> json) {
		img = json['img'];
		newThumb = json['new_thumb'];
		atime = json['atime'];
		offtm = json['offtm'];
		newImg = json['new_img'];
		thumb = json['thumb'];
		module = json['module'];
		reco = json['reco'];
		oid = json['oid'];
		ontm = json['ontm'];
		type = json['type'];
		target = json['target'];
		if (json['market'] != null) {
			market = new List<Null>();
		}
		uid = json['uid'];
		sId = json['_id'];
		id = json['id'];
		value = json['value'] != null ? new SpecialModelResBannerValue.fromJson(json['value']) : null;
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img'] = this.img;
		data['new_thumb'] = this.newThumb;
		data['atime'] = this.atime;
		data['offtm'] = this.offtm;
		data['new_img'] = this.newImg;
		data['thumb'] = this.thumb;
		data['module'] = this.module;
		data['reco'] = this.reco;
		data['oid'] = this.oid;
		data['ontm'] = this.ontm;
		data['type'] = this.type;
		data['target'] = this.target;
		if (this.market != null) {
      data['market'] =  [];
    }
		data['uid'] = this.uid;
		data['_id'] = this.sId;
		data['id'] = this.id;
		if (this.value != null) {
      data['value'] = this.value.toJson();
    }
		data['desc'] = this.desc;
		return data;
	}
}

class SpecialModelResBannerValue {
	double atime;
	int type;
	List<Null> url;
	String cover;
	String ename;
	int favs;
	String name;
	String lcover;
	bool isfeed;
	String id;
	List<Null> tag;
	int sn;
	SpecialModelResBannerValueUser user;
	String status;
	String desc;

	SpecialModelResBannerValue({this.atime, this.type, this.url, this.cover, this.ename, this.favs, this.name, this.lcover, this.isfeed, this.id, this.tag, this.sn, this.user, this.status, this.desc});

	SpecialModelResBannerValue.fromJson(Map<String, dynamic> json) {
		atime = json['atime'];
		type = json['type'];
		if (json['url'] != null) {
			url = new List<Null>();
		}
		cover = json['cover'];
		ename = json['ename'];
		favs = json['favs'];
		name = json['name'];
		lcover = json['lcover'];
		isfeed = json['isfeed'];
		id = json['id'];
		if (json['tag'] != null) {
			tag = new List<Null>();
		}
		sn = json['sn'];
		user = json['user'] != null ? new SpecialModelResBannerValueUser.fromJson(json['user']) : null;
		status = json['status'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['atime'] = this.atime;
		data['type'] = this.type;
		if (this.url != null) {
      data['url'] =  [];
    }
		data['cover'] = this.cover;
		data['ename'] = this.ename;
		data['favs'] = this.favs;
		data['name'] = this.name;
		data['lcover'] = this.lcover;
		data['isfeed'] = this.isfeed;
		data['id'] = this.id;
		if (this.tag != null) {
      data['tag'] =  [];
    }
		data['sn'] = this.sn;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['status'] = this.status;
		data['desc'] = this.desc;
		return data;
	}
}

class SpecialModelResBannerValueUser {
	int follower;
	int gender;
	double viptime;
	String gcid;
	int following;
	String name;
	String avatar;
	String id;
	bool isvip;

	SpecialModelResBannerValueUser({this.follower, this.gender, this.viptime, this.gcid, this.following, this.name, this.avatar, this.id, this.isvip});

	SpecialModelResBannerValueUser.fromJson(Map<String, dynamic> json) {
		follower = json['follower'];
		gender = json['gender'];
		viptime = json['viptime'];
		gcid = json['gcid'];
		following = json['following'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
		isvip = json['isvip'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['follower'] = this.follower;
		data['gender'] = this.gender;
		data['viptime'] = this.viptime;
		data['gcid'] = this.gcid;
		data['following'] = this.following;
		data['name'] = this.name;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		data['isvip'] = this.isvip;
		return data;
	}
}

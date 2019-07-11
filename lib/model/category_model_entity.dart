class CategoryModelEntity {
	String msg;
	CategoryModelRes res;
	int code;

	CategoryModelEntity({this.msg, this.res, this.code});

	CategoryModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		res = json['res'] != null ? new CategoryModelRes.fromJson(json['res']) : null;
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

class CategoryModelRes {
	List<CategoryModelResCategory> category;

	CategoryModelRes({this.category});

	CategoryModelRes.fromJson(Map<String, dynamic> json) {
		if (json['category'] != null) {
			category = new List<CategoryModelResCategory>();(json['category'] as List).forEach((v) { category.add(new CategoryModelResCategory.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.category != null) {
      data['category'] =  this.category.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CategoryModelResCategory {
	String picassoCover;
	double atime;
	String rname;
	int count;
	int type;
	String coverTemp;
	String cover;
	List<Null> filter;
	String ename;
	String name;
	int rank;
	String icover;
	int sn;
	String id;

	CategoryModelResCategory({this.picassoCover, this.atime, this.rname, this.count, this.type, this.coverTemp, this.cover, this.filter, this.ename, this.name, this.rank, this.icover, this.sn, this.id});

	CategoryModelResCategory.fromJson(Map<String, dynamic> json) {
		picassoCover = json['picasso_cover'];
		atime = json['atime'];
		rname = json['rname'];
		count = json['count'];
		type = json['type'];
		coverTemp = json['cover_temp'];
		cover = json['cover'];
		if (json['filter'] != null) {
			filter = new List<Null>();
		}
		ename = json['ename'];
		name = json['name'];
		rank = json['rank'];
		icover = json['icover'];
		sn = json['sn'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picasso_cover'] = this.picassoCover;
		data['atime'] = this.atime;
		data['rname'] = this.rname;
		data['count'] = this.count;
		data['type'] = this.type;
		data['cover_temp'] = this.coverTemp;
		data['cover'] = this.cover;
		if (this.filter != null) {
      data['filter'] =  [];
    }
		data['ename'] = this.ename;
		data['name'] = this.name;
		data['rank'] = this.rank;
		data['icover'] = this.icover;
		data['sn'] = this.sn;
		data['id'] = this.id;
		return data;
	}
}

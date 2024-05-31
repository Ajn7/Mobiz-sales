class VanSaleProducts {
  List<Data>? data;
  bool? success;

  VanSaleProducts({this.data, this.success});

  VanSaleProducts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  int? customerId;
  String? billMode;
  String? inDate;
  String? inTime;
  String? invoiceNo;
  String? deliveryNo;
  num? otherCharge;
  num? discount;
  String? roundOff;
  num? total;
  num? totalTax;
  num? grandTotal;
  num? receipt;
  num? balance;
  int? orderType;
  int? ifVat;
  int? vanId;
  int? userId;
  int? storeId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Detail>? detail;

  Data(
      {this.id,
      this.customerId,
      this.billMode,
      this.inDate,
      this.inTime,
      this.invoiceNo,
      this.roundOff,
      this.deliveryNo,
      this.otherCharge,
      this.discount,
      this.total,
      this.totalTax,
      this.grandTotal,
      this.receipt,
      this.balance,
      this.orderType,
      this.ifVat,
      this.vanId,
      this.userId,
      this.storeId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.detail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    billMode = json['bill_mode'];
    inDate = json['in_date'];
    inTime = json['in_time'];
    invoiceNo = json['invoice_no'];
    deliveryNo = json['delivery_no'];
    otherCharge = json['other_charge'];
    discount = json['discount'];
    total = json['total'];
    totalTax = json['total_tax'];
    roundOff = json['round_off'];
    grandTotal = json['grand_total'];
    receipt = json['receipt'];
    balance = json['balance'];
    orderType = json['order_type'];
    ifVat = json['if_vat'];
    vanId = json['van_id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['bill_mode'] = this.billMode;
    data['in_date'] = this.inDate;
    data['in_time'] = this.inTime;
    data['invoice_no'] = this.invoiceNo;
    data['delivery_no'] = this.deliveryNo;
    data['other_charge'] = this.otherCharge;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['grand_total'] = this.grandTotal;
    data['receipt'] = this.receipt;
    data['balance'] = this.balance;
    data['order_type'] = this.orderType;
    data['if_vat'] = this.ifVat;
    data['van_id'] = this.vanId;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  int? goodsOutId;
  int? itemId;
  String? productType;
  String? unit;
  int? convertQty;
  int? quantity;
  int? rate;
  int? prodiscount;
  int? taxable;
  num? taxAmt;
  int? mrp;
  num? amount;
  int? vanId;
  int? userId;
  int? storeId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? code;
  String? name;
  String? proImage;
  int? categoryId;
  int? subCategoryId;
  int? brandId;
  int? supplierId;
  int? taxId;
  int? taxPercentage;
  int? taxInclusive;
  int? price;
  int? baseUnitId;
  int? baseUnitQty;
  String? baseUnitDiscount;
  String? baseUnitBarcode;
  int? baseUnitOpStock;
  String? secondUnitPrice;
  int? secondUnitId;
  int? secondUnitQty;
  String? secondUnitDiscount;
  String? secondUnitBarcode;
  String? secondUnitOpStock;
  String? thirdUnitPrice;
  int? thirdUnitId;
  int? thirdUnitQty;
  String? thirdUnitDiscount;
  String? thirdUnitBarcode;
  String? thirdUnitOpStock;
  String? fourthUnitPrice;
  int? fourthUnitId;
  int? fourthUnitQty;
  String? fourthUnitDiscount;
  int? isMultipleUnit;
  String? fourthUnitOpStock;
  String? description;
  int? productQty;
  int? percentage;

  Detail(
      {this.id,
      this.goodsOutId,
      this.itemId,
      this.unit,
      this.convertQty,
      this.quantity,
      this.rate,
      this.prodiscount,
      this.taxable,
      this.taxAmt,
      this.mrp,
      this.amount,
      this.vanId,
      this.userId,
      this.storeId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.code,
      this.name,
      this.productType,
      this.proImage,
      this.categoryId,
      this.subCategoryId,
      this.brandId,
      this.supplierId,
      this.taxId,
      this.taxPercentage,
      this.taxInclusive,
      this.price,
      this.baseUnitId,
      this.baseUnitQty,
      this.baseUnitDiscount,
      this.baseUnitBarcode,
      this.baseUnitOpStock,
      this.secondUnitPrice,
      this.secondUnitId,
      this.secondUnitQty,
      this.secondUnitDiscount,
      this.secondUnitBarcode,
      this.secondUnitOpStock,
      this.thirdUnitPrice,
      this.thirdUnitId,
      this.thirdUnitQty,
      this.thirdUnitDiscount,
      this.thirdUnitBarcode,
      this.thirdUnitOpStock,
      this.fourthUnitPrice,
      this.fourthUnitId,
      this.fourthUnitQty,
      this.fourthUnitDiscount,
      this.isMultipleUnit,
      this.fourthUnitOpStock,
      this.description,
      this.productQty,
      this.percentage});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsOutId = json['goods_out_id'];
    itemId = json['item_id'];
    productType=json['product_type'];
    unit = json['unit'];
    convertQty = json['convert_qty'];
    quantity = json['quantity'];
    rate = json['rate'];
    prodiscount = json['prodiscount'];
    taxable = json['taxable'];
    taxAmt = json['tax_amt'];
    mrp = json['mrp'];
    amount = json['amount'];
    vanId = json['van_id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    name = json['name'];
    proImage = json['pro_image'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    brandId = json['brand_id'];
    supplierId = json['supplier_id'];
    taxId = json['tax_id'];
    taxPercentage = json['tax_percentage'];
    taxInclusive = json['tax_inclusive'];
    price = json['price'];
    baseUnitId = json['base_unit_id'];
    baseUnitQty = json['base_unit_qty'];
    baseUnitDiscount = json['base_unit_discount'];
    baseUnitBarcode = json['base_unit_barcode'];
    baseUnitOpStock = json['base_unit_op_stock'];
    secondUnitPrice = json['second_unit_price'];
    secondUnitId = json['second_unit_id'];
    secondUnitQty = json['second_unit_qty'];
    secondUnitDiscount = json['second_unit_discount'];
    secondUnitBarcode = json['second_unit_barcode'];
    secondUnitOpStock = json['second_unit_op_stock'];
    thirdUnitPrice = json['third_unit_price'];
    thirdUnitId = json['third_unit_id'];
    thirdUnitQty = json['third_unit_qty'];
    thirdUnitDiscount = json['third_unit_discount'];
    thirdUnitBarcode = json['third_unit_barcode'];
    thirdUnitOpStock = json['third_unit_op_stock'];
    fourthUnitPrice = json['fourth_unit_price'];
    fourthUnitId = json['fourth_unit_id'];
    fourthUnitQty = json['fourth_unit_qty'];
    fourthUnitDiscount = json['fourth_unit_discount'];
    isMultipleUnit = json['is_multiple_unit'];
    fourthUnitOpStock = json['fourth_unit_op_stock'];
    description = json['description'];
    productQty = json['product_qty'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goods_out_id'] = this.goodsOutId;
    data['item_id'] = this.itemId;
    data['unit'] = this.unit;
    data['convert_qty'] = this.convertQty;
    data['product_type'] = this.productType;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['prodiscount'] = this.prodiscount;
    data['taxable'] = this.taxable;
    data['tax_amt'] = this.taxAmt;
    data['mrp'] = this.mrp;
    data['amount'] = this.amount;
    data['van_id'] = this.vanId;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['name'] = this.name;
    data['pro_image'] = this.proImage;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['brand_id'] = this.brandId;
    data['supplier_id'] = this.supplierId;
    data['tax_id'] = this.taxId;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_inclusive'] = this.taxInclusive;
    data['price'] = this.price;
    data['base_unit_id'] = this.baseUnitId;
    data['base_unit_qty'] = this.baseUnitQty;
    data['base_unit_discount'] = this.baseUnitDiscount;
    data['base_unit_barcode'] = this.baseUnitBarcode;
    data['base_unit_op_stock'] = this.baseUnitOpStock;
    data['second_unit_price'] = this.secondUnitPrice;
    data['second_unit_id'] = this.secondUnitId;
    data['second_unit_qty'] = this.secondUnitQty;
    data['second_unit_discount'] = this.secondUnitDiscount;
    data['second_unit_barcode'] = this.secondUnitBarcode;
    data['second_unit_op_stock'] = this.secondUnitOpStock;
    data['third_unit_price'] = this.thirdUnitPrice;
    data['third_unit_id'] = this.thirdUnitId;
    data['third_unit_qty'] = this.thirdUnitQty;
    data['third_unit_discount'] = this.thirdUnitDiscount;
    data['third_unit_barcode'] = this.thirdUnitBarcode;
    data['third_unit_op_stock'] = this.thirdUnitOpStock;
    data['fourth_unit_price'] = this.fourthUnitPrice;
    data['fourth_unit_id'] = this.fourthUnitId;
    data['fourth_unit_qty'] = this.fourthUnitQty;
    data['fourth_unit_discount'] = this.fourthUnitDiscount;
    data['is_multiple_unit'] = this.isMultipleUnit;
    data['fourth_unit_op_stock'] = this.fourthUnitOpStock;
    data['description'] = this.description;
    data['product_qty'] = this.productQty;
    data['percentage'] = this.percentage;
    return data;
  }
}

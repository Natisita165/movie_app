class Rental{
  int rentalId;
  String rentalDate;
  int customerId;
  String returnDate;
  int staffId;


  Rental(this.rentalId, this.rentalDate, this.customerId, this.returnDate,
      this.staffId);

  Map toJson()=>{
      "rental_id": rentalId,
      "rental_date": rentalDate,
      "customer_id": customerId,
      "return_date": returnDate,
      "staff_id": staffId};
}
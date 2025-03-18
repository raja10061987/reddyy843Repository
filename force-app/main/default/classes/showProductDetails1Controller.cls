public class showProductDetails1Controller 
{
     public string productName{get;set;}
     public integer productCode {get;set;}
     public integer quantity {get;set;}
     public Date expiryDate {get;set;}
     public boolean isInStock {get;set;}
   public showProductDetails1Controller()
   {
    productName='Raja';
    productCode = 123;
    this.quantity = 10;
    this.expiryDate = system.today();
    this.isInStock = true;
    
   }
}
public class ProductController 
{
    public string productName {get;set;}
    public integer productCode {get;set;}
    public integer productQuantity {get;set;}
    public string manufacturer {get;set;}
    public decimal unitPrice {get;set;}
    public Date ManufacturingDate {get;set;}
    public Date ExpiryDate {get;set;}
    public boolean isInStock{get;set;}
    
    public ProductController()
    {
      this.productName = 'laptop';
      this.productCode = 123;
      productQuantity = 10;
      manufacturer = 'infosys';
      unitPrice = 20.00;
      ManufacturingDate = system.today();
      ExpiryDate = system.today() + 10;
      isInstock = false;
    }
    
  
    
}
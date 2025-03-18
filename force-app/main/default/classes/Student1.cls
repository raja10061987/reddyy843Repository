public with sharing class Student1 
{
    public Student1() {

    }
    public enum Category {PRIMARY,SECONDARY,SENIOR_SECONDARY}
    integer id;
    string name;
    Category studentCategory;

    public Student1(integer id,string name,Category studentCategory)
    {
        this.id = id;
        this.name = name;
        this.studentCategory = studentCategory;

    }
   public Integer getId()
   {
    return id;
   }
   public string sName()
   {
    return name;
   }
   public Category getStudentCategory()
   {
    return studentCategory;  // PRIMARY
   }
   public string studentCategoryAsString()
   {
    return studentCategory.name();
   }
  
}
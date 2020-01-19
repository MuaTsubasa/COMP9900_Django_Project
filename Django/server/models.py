from django.db import models


# Create your models here.

class Patient(models.Model):
    GENDER_choices = (
        ('M', 'M'),
        ('F', 'F')
    )
    INSURANCE_TYPE_choices = (
        ('Medicare', 'Medicare'),
        ('Private Health Insurance', 'Private Health Insurance')
    )
    PatientID = models.AutoField(primary_key=True,)
    Email = models.EmailField()
    First_name = models.CharField(max_length=45)
    Last_name = models.CharField(max_length=45)
    DateOfBirth = models.DateField()
    Password = models.CharField(max_length=100)
    Gender = models.CharField(choices=GENDER_choices, max_length=10)
    Address = models.CharField(max_length=500)
    Zipcode = models.CharField(max_length=4)
    Insurance = models.CharField(choices=INSURANCE_TYPE_choices, max_length=45 )

    def __str__(self):
        return self.Last_name
    class Meta:
        verbose_name = "Patient"
        verbose_name_plural = verbose_name
    def get_fields_names(self):
        fields = Patient._meta.fields
        field_names = [f.name for f in fields]
        return field_names


class Clinic(models.Model):
    ClinicID = models.AutoField(primary_key=True)
    Email = models.EmailField()
    Password = models.CharField(max_length=45)
    ClinicName = models.CharField(max_length=100)
    Address = models.CharField(max_length=500)
    address_latitude = models.CharField(max_length=20)
    address_longitude = models.CharField(max_length=20)
    #Be careful here is ZipCode, not Zipcode
    ZipCode = models.CharField(max_length=4)
    Contact = models.CharField(max_length=20)
    TimeTable = models.CharField(max_length=2000,null=True, blank=True)
    Questiones = models.TextField(max_length=5000,null=True, blank=True)
    CT = models.CharField(max_length=2)
    MRI = models.CharField(max_length=2)
    X_Ray = models.CharField(max_length=2)
    ChildrenImage = models.CharField(max_length=2)
    Pregnancy_Pelvic_Imaging = models.CharField(max_length=2)
    Cardiology = models.CharField(max_length=2)
    Dentistry = models.CharField(max_length=2)
  
    def get_fields_names(self):
        fields = Clinic._meta.fields
        field_names = [f.name for f in fields]
        return field_names
    class Meta:
        verbose_name = "Clinic"
        verbose_name_plural = verbose_name


class Appointment(models.Model):
    AppointmentID = models.AutoField(primary_key=True)
    PatientID = models.IntegerField()
    ClinicID = models.IntegerField()
    Date = models.DateField()
    Time = models.CharField(max_length=45)
    Examination = models.CharField(max_length=45)
    Status = models.CharField(max_length=45)
    Questionaires = models.CharField(max_length=5000)
    file = models.FileField(upload_to='file/', null=True, blank=True)
    requirement = models.FileField(upload_to='requirement/', null=True, blank=True)
    class Meta:
        verbose_name = "Appointment"
        verbose_name_plural = verbose_name
    def get_fields_names(self):
        fields = Appointment._meta.fields
        field_names = [f.name for f in fields]
        return field_names
    def __str__(self):
        return "Appointment " + self.Time

from datetime import datetime
from django.db.models import Count, Q
from django.shortcuts import render,redirect
from django.http import JsonResponse, HttpResponseRedirect,HttpResponseNotFound,Http404
from django.core.exceptions import PermissionDenied
from django.urls import reverse
from django.views import View
from django.core.files.base import ContentFile
from .models import Patient,Appointment,Clinic
# from .tests import Text_email,send_no_result,send_ok_result,send_report_upload,send_requirement
# auto-email sending function suspended
import json
def JsonLoadsString(req):
    string = req.GET.get("string")
    result = json.loads(string)
    return JsonResponse({"result":result})
def redirect_to_login():
    return HttpResponseRedirect(reverse("signin"))
class HomeView(View):
    def get(self, req):
        return render(req, 'home.html')
class PresentationView(View):
    def get(self, req):
        return render(req, 'presentation.html')
class SignInView(View):
    def get(self, req):
        return render(req, 'signin.html')
    def post(self, req):
        role = req.POST.get('role', None)
        email = req.POST.get('email', None)
        error = []
        password = req.POST.get('password', None)
        if role == "patient":
            if Patient.objects.filter(Email=email, Password=password):
                p = Patient.objects.filter(Email=email, Password=password)[0]
                req.session['user'] = {
                    "id":p.PatientID,
                    "email": p.Email,
                    "name": p.Last_name,
                    "role": role,
                }
                return HttpResponseRedirect(reverse("home"))
            else:
                error.append("Account or password is wrong！")
                return render(req, 'signin.html', {"error": error})
        else:
            if Clinic.objects.filter(Email=email, Password=password):
                p = Clinic.objects.filter(Email=email, Password=password)[0]
                req.session['clinic_user'] = {
                    "id":p.ClinicID,
                    "email": p.Email,
                    "name": p.ClinicName,
                    "role": role
                }
                return HttpResponseRedirect(reverse("home"))
            else:
                error.append("Account or password is wrong！")
                return render(req, 'signin.html', {"error": error})
class SignUpView(View):
    role = "patient"
    req = None
    error = []
    def get_role(self):
        role = self.req.GET.get("role", None)
        if role:
            self.role = role
        return self.role
    def get_tempt(self):
        self.get_role()
        if self.role == "doc":
            tempt = "clinic/clinic_signup.html"
        else:
            tempt = 'patient/patient_signup.html'
        return tempt
    def get(self, req):
        self.req = req
        tempt = self.get_tempt()
        return render(req, tempt)
    def post(self, req):
        self.req = req
        role = self.get_role()
        tempt = self.get_tempt()
        if role == "patient":
            if self.create_user(Patient):
                return HttpResponseRedirect(reverse('signin'))
        else:
            signup_dict= {'Email':'','Password':'','ClinicName':'', 'Address':'','ZipCode':'', 'address_latitude':'', 'address_longitude':'','Contact':'','X_Ray':'','ChildrenImage':'','CT':'','MRI':'','Pregnancy_Pelvic_Imaging':'','Dentistry':'','Cardiology':''}
            examination_fields = ['X_Ray','ChildrenImage','CT','MRI','Pregnancy_Pelvic_Imaging','Dentistry','Cardiology']
            examinations = req.POST.getlist('examinations[]')
            for key in signup_dict:
                if key in examination_fields:
                    if key in examinations:
                        signup_dict[key] = '1'
                    else:
                        signup_dict[key] = '0'
                else:
                    signup_dict[key] = req.POST.get(key)
            
            clinic = Clinic(
                Email = signup_dict['Email'],
                Password = signup_dict['Password'],
                ClinicName = signup_dict['ClinicName'],
                Address = signup_dict['Address'],
                ZipCode = signup_dict['ZipCode'],
                address_latitude = signup_dict['address_latitude'],
                address_longitude = signup_dict['address_longitude'],
                Contact = signup_dict['Contact'],
                X_Ray = signup_dict['X_Ray'],
                ChildrenImage = signup_dict['ChildrenImage'],
                CT = signup_dict['CT'],
                Pregnancy_Pelvic_Imaging = signup_dict['Pregnancy_Pelvic_Imaging'],
                MRI = signup_dict['MRI'],
                Dentistry = signup_dict['Dentistry'],
                Cardiology = signup_dict['Cardiology']
            )
            clinic.save()
            return HttpResponseRedirect(reverse('signin'))

    def create_user(self, model):
        data = self.req.POST
        obj = model()
        email = data.get("Email", None)
        if model.objects.filter(Email = email):
            self.error.append("Currently email has been registered！")
        else:
            for field in obj.get_fields_names()[1:]:
                value = data.get(field, None)
                if not value:
                    self.error.append("{} is invalid!".format(field))
                else:
                    setattr(obj, field, value)
        if not self.error:
            obj.save()
            return True
        else:
            return False
class LogoutView(View):
    def get(self, req):
        req.session['user'] = None
        req.session['clinic_user'] = None
        return HttpResponseRedirect(reverse('signin'))
def ChatbotView(req):
    return render(req,'chat_box.html')
###### Clinic ######
def ClinicSearchView(req):
    if req.session['clinic_user']:
        patient_id_list = Patient.objects.values_list("PatientID", flat=True)
        patient_id_list = list(patient_id_list)
        result = []
        for patient_id in patient_id_list:
            query = Patient.objects.get(PatientID = patient_id)
            result.append(query)
        return render(req, 'clinic/clinic_search.html', context={"result":result})
    else:
        return HttpResponseRedirect('signin')
def GetSchedule(req):
    if req.session['clinic_user']:
        clinic_id=req.session['clinic_user']['id']
        input_date = req.POST.get("date")
        input_date = (datetime.strptime(input_date,"%Y-%m-%d").date()).isocalendar()
        dates_of_week = []
        for i in range(1,8):
            dates_of_week.append(str(datetime.date(datetime.strptime(str(input_date[0])+str(input_date[1])+str(i), '%G%V%u'))))
        schedule_dict = {}
        for i in dates_of_week:
            schedule_dict[i] = list(Appointment.objects.filter(Date = i, ClinicID = clinic_id, Status__in = ["Approved", "Requirement Added"]).values("Time", "PatientID"))
            if len(schedule_dict[i])>0:
                for query in schedule_dict[i]:
                    patient_id = query["PatientID"]
                    patient_name = Patient.objects.filter(PatientID = patient_id).values("First_name", "Last_name")
                    query.update(patient_name[0])
        return JsonResponse({"dates_of_week":dates_of_week,"schedule_dict":schedule_dict})
class ClinicDashBoardView(View):
    def get(self, req):
        if req.session['clinic_user']:
            clinic_user = req.session['clinic_user']
            clinic_id=clinic_user['id']
            pending_count = Appointment.objects.filter(ClinicID = clinic_id, Status = 'Pending').count()
            context = {
                "pending_count":pending_count,
            }
            return render(req, 'clinic/dashboard.html', context)
        else:
            return HttpResponseRedirect('signin')
class RequestListView(View):
    def get(self, req):
        if req.session['clinic_user']:
            clinic_user = req.session['clinic_user']
            clinic_id = clinic_user["id"]
            #bookings = Appointment.objects.raw("SELECT * FROM server_clinic WHERE ClinicID = %i AND Date < CURDATE()" %(clinic_id))
            status = req.GET.get("status", "Any status")
            if status == "Any status":
                bookings = Appointment.objects.filter(ClinicID = clinic_id).values()
                count = bookings.count()
            else:
                bookings = Appointment.objects.filter(ClinicID = clinic_id, Status = status).values()
                count = bookings.count() 
            for query in bookings:
                patient_id = query["PatientID"]
                patient_info = Patient.objects.filter(PatientID = patient_id).values("First_name", "Last_name", "Email")
                query.update(patient_info[0])
                que_questionaire = query["Questionaires"]
                if que_questionaire != None:
                    query["Questionaires"] = json.loads(que_questionaire)
                else:
                    query["Questionaires"] = {"": "No Questionaires yet"}
            context = { "bookings":bookings, "count":count, "status":status}
            return render(req, 'clinic/requestlist.html', context)
        else:
            return HttpResponseRedirect('signin')  
    def post(self,req):
        if req.session['clinic_user']:
            app_id = req.POST.get("app_id")
            ap = Appointment.objects.filter(AppointmentID=int(app_id))[0]
            file = req.FILES.get("file")
            file_content = ContentFile(file.read())
            ap.requirement.save(file.name, file_content)
            ap.Status = "Requirement Added"
            ap.save()
            # p_id = ap.PatientID
            # Patient_query = Patient.objects.filter(PatientID = p_id)[0]
            # clinic_id = ap.ClinicID
            # clinic_query = Clinic.objects.filter(ClinicID = clinic_id)[0]
            # p_name = Patient_query.First_name
            # p_email = Patient_query.Email
            # app_exam = ap.Examination
            # c_name = clinic_query.ClinicName
            # c_date = ap.Date
            # c_time = ap.Time
            # c_contact = clinic_query.Contact
            # send_requirement(p_name,p_email,app_exam,c_name,c_date,c_time,c_contact)
            return HttpResponseRedirect(reverse('requestlist'))
        else:
            return HttpResponseRedirect('signin')
def cancel_reqest(req):
    app_id=req.POST.get("id")
    datet=req.POST.get("date")
    info = Appointment.objects.get(AppointmentID = app_id)
    info.Status = 'Cancel'
    info.save()
    # u_id = info.PatientID
    # email = Patient.objects.get(PatientID=u_id).Email
    # username = Patient.objects.get(PatientID=u_id).First_name
    # type = info.Examination
    # clinic_id =info.ClinicID
    # cur_date = info.Date
    # cur_time = info.Time
    # contact = Clinic.objects.get(ClinicID=clinic_id).Contact
    # clinic_name = Clinic.objects.get(ClinicID=clinic_id).ClinicName
    # send_no_result(username, email, type, clinic_name, datet, cur_date, cur_time, contact)
    return JsonResponse({"Cancel": "OK"})
def approve_reqest(req):
    app_id=req.POST.get("id")
    info=Appointment.objects.get(AppointmentID=app_id)
    info.Status='Approved'
    info.save()
    # u_id=info.PatientID
    # email=Patient.objects.get(PatientID=u_id).Email
    # username=Patient.objects.get(PatientID=u_id).First_name
    # type = info.Examination
    # clinic_id = info.ClinicID
    # clinic_name = Clinic.objects.get(ClinicID = clinic_id).ClinicName
    # date = info.Date
    # time = info.Time
    # contact=Clinic.objects.get(ClinicID = clinic_id).Contact
    # send_ok_result(username, email, type, clinic_name, date, time, contact)
    return JsonResponse({"Approved":"OK"})
class UploadReportView(View):
    def get(self, req):
        if req.session['clinic_user']:
            # today = datetime.today().strftime('%Y-%m-%d')
            clinic_user = req.session['clinic_user']
            clinic_id = clinic_user["id"]
            #bookings = Appointment.objects.raw("SELECT * FROM server_clinic WHERE ClinicID = %i AND Date < CURDATE()" %(clinic_id))
            status = req.GET.get("status", "Any status")
            if status == "Any status":
                bookings = Appointment.objects.filter(ClinicID = clinic_id).values()
                count = bookings.count()
            else:
                bookings = Appointment.objects.filter(ClinicID = clinic_id, Status = status).values()
                count = bookings.count() 
            for query in bookings:
                patient_id = query["PatientID"]
                patient_info = Patient.objects.filter(PatientID = patient_id).values("First_name", "Last_name", "Email")
                query.update(patient_info[0])
                que_questionaire = query["Questionaires"]
                if que_questionaire != None:
                    query["Questionaires"] = json.loads(que_questionaire)
                else:
                    query["Questionaires"] = {"": "No Questionaires yet"}
            context = { "bookings":bookings, "count":count, "status":status}
            
            return render(req, 'clinic/upload_report.html', context)
        else:
            return HttpResponseRedirect('signin')

    def post(self, req):
        app_id = req.POST.get("app_id")
        ap = Appointment.objects.filter(AppointmentID=int(app_id))[0]
        file = req.FILES.get("file")
        file_content = ContentFile(file.read())
        ap.file.save(file.name, file_content)
        ap.Status = "Report Uploaded"
        ap.save()
        # p_id = ap.PatientID
        # Patient_query = Patient.objects.filter(PatientID = p_id)[0]
        # clinic_id = ap.ClinicID
        # clinic_query = Clinic.objects.filter(ClinicID = clinic_id)[0]
        # p_name = Patient_query.First_name
        # p_email = Patient_query.Email
        # app_exam = ap.Examination
        # c_name = clinic_query.ClinicName
        # c_date = ap.Date
        # c_time = ap.Time
        # c_contact = clinic_query.Contact
        # send_report_upload(p_name,p_email,app_exam,c_name,c_date,c_time,c_contact)
        return HttpResponseRedirect(reverse('upload_report'))
def get_statistics(req):
    if req.session['clinic_user']:
        if req.method=="GET":
            clinic_user = req.session['clinic_user']
            clinic_id = clinic_user['id']
            sure_score_list = []
            info = Appointment.objects.filter(ClinicID=clinic_id)
            sure_score_list.append(info.filter(Status='Approved').count())
            sure_score_list.append(info.filter(Status='Cancel').count())
            sure_score_list.append(info.filter(Status='Pending').count())
            sure_score_list.append(info.filter(Status='Report Uploaded').count())
            sure_score_list.append(info.filter(Status='Requirement Added').count())
            #SELECT * FROM Appointment WHERE clinic=clinic_id ORFERBY date
            info = Appointment.objects.filter(ClinicID=clinic_id).order_by('Date')
            date_list = list(info.values_list('Date',flat=True))
            count_list=[]
            for date in date_list:
                count = info.filter(Date=date).count()
                count_list.append(count)
            info = Appointment.objects.filter(ClinicID=clinic_id)
            time_list = list(info.values_list("Time", flat = True))
            count_time = []
            for time in time_list:
                count = info.filter(Time = time).count()
                count_time.append(count)
            current_time = datetime.now().strftime('%Y-%m-%d')
            context = {
                "clinic_name": clinic_user["name"],
                'time_list':time_list,
                'count_time':count_time,
                'result_score': count_list,
                'date_list': date_list,
                'current_time':current_time,
                'sure_score_list':sure_score_list,
            }
            print(context)
            return render(req,'clinic/statictics.html',context)
    else:
        return HttpResponseRedirect('signin')  
class ClinicProfileView(View):
    error=[]
    req = None
    def get(self,req):
        self.req = req
        if req.session['clinic_user']:
            clinic_user = req.session['clinic_user']
            clinic_id = clinic_user['id']
            result = Clinic.objects.get(ClinicID = clinic_id)
            examinations = list(Clinic.objects.filter(ClinicID = clinic_id).values())[0]
            exam_dict = dict()
            for field in Clinic().get_fields_names()[11:]:
                exam_dict[field] = examinations[field]
            print(exam_dict)
            context = {"basic":result,
                        "exam_dict":exam_dict.items(),
                        "error":self.error}
            return render(req, 'clinic/clinic_profile.html', context)
        else:
            return HttpResponseRedirect('signin')  
    def post(self,req):
        self.req = req
        clinic_user = req.session['clinic_user']
        clinic_id = clinic_user["id"]
        clinic = Clinic.objects.get(ClinicID = clinic_id)
        if self.test_verify(Clinic,clinic):
            for field in clinic.get_fields_names()[3:9]: #column 3 to column 8
                value = req.POST.get(field, None)
                setattr(clinic, field, value)
                clinic.save()
            if clinic.Password == "":
                clinic.Password = self.req.POST.get("original_password")
                clinic.save()
            examinations = req.POST.getlist('examinations[]')
            for field in clinic.get_fields_names()[11:]:
                if field in examinations:
                    value = '1'
                    setattr(clinic, field, value)
                    clinic.save()
                else:
                    value = '0'
                    setattr(clinic, field, value)
                    clinic.save()
        return HttpResponseRedirect(reverse('clinic_profile'))

    def test_verify(self, model,query):
        email_field = {"old_email":"", "new_email":"","Email":""}
        for field in email_field:
            email_field[field] = self.req.POST.get(field, None)
        if "" not in email_field.values():
            if email_field["new_email"] == email_field["old_email"]:
                self.error.append("Please enter a different email")
            else:
                if email_field["Email"] != email_field["new_email"]:
                    self.error.append("Confirm email and new email does not match")
                else:
                    if model.objects.filter(Email = email_field["new_email"]):
                        self.error.append("Current email has been registered, please enter another email")
                    else:
                        query.Email = email_field["Email"]
        password_field = {"original_password":"","old_password":"", "new_password":"","Password":""}
        for field in password_field:
            password_field[field] = self.req.POST.get(field, None)
        if "" not in password_field.values():
            if password_field["old_password"] != password_field["original_password"]:
                self.error.append("Old password does not match")
            else:
                if password_field["new_password"] != password_field["Password"]:
                    self.error.append("Confirm password does not match")
                else:
                    if password_field["old_password"] == password_field["Password"]:
                        self.error.append("Please enter a different new password")
                    else:
                        query.Passowrd = password_field["Password"]
        if not self.error:    
            query.save()
            self.error = []
            return True
        else:
            return False
class TimeAndQuestionBuild(View):
    def get(self, req):
        if req.session["clinic_user"]:
            user = req.session["clinic_user"]
            clinic_id = user["id"]
            query_set = Clinic.objects.filter(ClinicID = clinic_id).values("TimeTable","Questiones")
            query_list = query_set[0]
            print("query list", query_list)
            if query_list["Questiones"] != None:
                questiones_list = json.loads(query_list["Questiones"])
            else:
                questiones_list = list()
            if query_list["TimeTable"] != None:
                time_dict = json.loads(query_list["TimeTable"])
            else:
                time_dict = dict()
            context = {
                "Questiones": questiones_list,
                "Question_count": range(0,abs(len(questiones_list)-10)),
                "TimeTable": time_dict.items(),
                "Time_count":range(0,abs(len(time_dict)-24)),
            }
            return render(req, "clinic/question_and_time.html",context)
        else:
            return HttpResponseRedirect('signin') 
    def post(self,req):
        user = req.session["clinic_user"]
        clinic_id = user["id"]
        question_list =req.POST.getlist("question_list[]")
        time_list =req.POST.getlist("timelist[]")
        slot_list =req.POST.getlist("slotlist[]")
        time_dict = dict()
        i = 0
        while i<(len(question_list)):
            if question_list[i] == '' or question_list[i] == ' ':
                question_list.remove(question_list[i])
            else:
                i+=1
        for i in range(0, len(time_list)):
            if len(time_list[i])>1:
                time_dict.update({time_list[i]:slot_list[i]})
        time_dict_string = json.dumps(time_dict)
        question_list_sting=json.dumps(question_list)
        clinic = Clinic.objects.get(ClinicID = clinic_id)
        clinic.TimeTable = time_dict_string
        clinic.Questiones = question_list_sting
        clinic.save()
        return HttpResponseRedirect(reverse('time_and_question'))
###### Patient Appointment.html ######
def monthRange(beginDate, endDate):
    monthSet = set()
    for date in dateRange(beginDate, endDate):
        monthSet.add(date[0:7])
    monthList = []
    for month in monthSet:
        monthList.append(month)
    return sorted(monthList)
def dateRange(beginDate, endDate):
    dates = []
    dt = datetime.datetime.strptime(beginDate, "%Y-%m-%d")
    date = beginDate[:]
    while date <= endDate:
        dates.append(date)
        dt = dt + datetime.timedelta(1)
        date = dt.strftime("%Y-%m-%d")
    return dates
class AppointmentView(View):
    def get(self, req):
        if req.session['user']:
            user = req.session['user']
            patient_id = user['id']
            query = Patient.objects.filter(PatientID=patient_id).values("Email", "First_name","Last_name")
            query_dict = list(query)[0]
            patient_name = query_dict["First_name"] + " " + query_dict["Last_name"]
            patient_email = query_dict["Email"]
            result = Clinic.objects.all()
            context = {
                'nav': 'appointment',
                'info': result, # result = Clinic.objects.all()
                'patient_name': patient_name, # query_dict["First_name"] + " " + query_dict["Last_name"]
                'patient_email': patient_email, #query_dict["Email"]
                }
            return render(req,'patient/appointment.html', context)
        else:
            return HttpResponseRedirect('signin') 
def Step_1(req):
    import re
    examination = req.POST.get("info")
    info_list=[]#returned result
    infos = Clinic.objects.filter(**{examination: '1'})#Clinic.objects.raw("SELECT * FROM server_clinic WHERE %s ='1'" %(examination))
    for i in range(0, len(infos)):
        data = {"clinic_name": re.sub("\s+","",infos[i].ClinicName),
                "clinic_email": infos[i].Email,
                "address": re.sub("\s+","",infos[i].Address),
                "zip_code": infos[i].ZipCode,
                "contact": infos[i].Contact,
                'clinic_id':infos[i].ClinicID,
                "clinic_latitude":float(infos[i].address_latitude),
                "clinic_logitude":float(infos[i].address_longitude),
                "examination":examination,
            }
        info_list.append(data)
    count = len(infos)
    return JsonResponse({"info":info_list,'count':count, "type":examination})#result={{"info":info_list,'count':count, "type":keyword}}
def Step_2(req):
    clinic_id = req.POST.get("clinic_id")
    query_set = Clinic.objects.filter(ClinicID = clinic_id).values("ClinicName","Email","Contact","Address","Questiones")
    clinic = query_set[0]
    question_str = clinic["Questiones"]
    Question_list = json.loads(question_str)
    ques_count = len(Question_list)
    return JsonResponse({"ques_list":Question_list,"ques_count":ques_count,"clinic_name": clinic["ClinicName"],"clinic_email":clinic["Email"],"clinic_contact": clinic["Contact"],"clinic_address": clinic["Address"]})
def Step_3(req):
    clinic_id = req.POST.get("clinic_id") # ID of selected clinic
    date = req.POST.get("date") # Date string of selected date
    #print("clinic id and date get from front-end", clinic_id, date)
    query_time = Appointment.objects.filter(Date=date,ClinicID=clinic_id).values_list('Time',flat=True)
    #print("Existed appointment record for selected clinic at selected date", query_time)
    query_time = list(query_time)
    query_timetable = Clinic.objects.filter(ClinicID=clinic_id).values("TimeTable")
    query_timelist = list(query_timetable)[0]
    time_dict = json.loads(query_timelist["TimeTable"]) #Read dumped string to dict
    #print("TimeTable dict queried from database", time_dict)
    time_keys = []
    for key,value in time_dict.items():
        if key != '' and value != '':
            time_dict[key] = int(value)
            if key in query_time:
                if time_dict[key] > 1:
                    time_dict[key] -= 1
                else:
                    time_dict[key] = "Unavailable"
    for key in time_dict:
        if time_dict[key] != '':
            if time_dict[key] != "Unavailable":
                time_keys.append(key)
            else:
                time_keys.append("Unavailable")
    #print("Processed Timetable using Python language and data structure", time_keys )
    return JsonResponse({"info":time_keys})
def Step_6(req):
    user=req.session['user']
    id=user['id']
    clinic_id = req.POST.get("clinic_id")
    patient_name = req.POST.get("patient_name")
    patient_email = req.POST.get("patient_email")
    examination = req.POST.get("examination")
    date = req.POST.get("date")
    time = req.POST.get("time")
    answers = req.POST.get("answers")
    answers_list = json.loads(answers)
    question_query = Clinic.objects.get(ClinicID = clinic_id).Questiones
    question_list = json.loads(question_query)
    Question_dict = dict() 
    for i in range(0, len(answers_list)):
        Question_dict.update({question_list[i]:answers_list[i]})
    question_string = json.dumps(Question_dict)
    clinic_query = Clinic.objects.get(ClinicID = clinic_id)
    info=Appointment(
    PatientID = id,
    ClinicID = clinic_id,
    Date = date,
    Time = time,
    Examination = examination,
    Status = 'Pending',
    Questionaires = question_string,
    )
    info.save()
    # clinic_name = clinic_query.ClinicName
    # clinic_contact = clinic_query.Contact
    # clinic_address = clinic_query.Address
    # clinic_email = clinic_query.Email
    # Text_email(patient_name,patient_email,examination,clinic_name,clinic_contact,clinic_address,clinic_email,date,time)
    return JsonResponse({"tutes":"OK"})
###### Patient ######
class PatientBookingView(View):
    def get(self, req):
        if req.session['user']:
            user = req.session['user']
            patient_id = user["id"]
            user = Patient.objects.get(PatientID = patient_id)
            status = req.GET.get("status", "Any status")
            if status == "Any status":
                bookings = Appointment.objects.filter(PatientID = patient_id).values()
            else:
                bookings = Appointment.objects.filter(PatientID = patient_id, Status = status).values()
            count = bookings.count()
            for query in bookings:
                clinic_id = query["ClinicID"]
                clinic_info = Clinic.objects.filter(ClinicID = clinic_id).values("ClinicName", "Contact","Email")
                query.update(clinic_info[0])
                que_questionaire = query["Questionaires"]
                if que_questionaire != None:
                    query["Questionaires"] = json.loads(que_questionaire)
                else:
                    query["Questionaires"] = {"": "No Questionaires yet"}
            context = {"user":user, "bookings":bookings, "count":count}
            return render(req, 'patient/bookings.html', context)
        else:
            return HttpResponseRedirect('signin') 
class ProfileView(View):
    error=[]
    req = None
    def get(self,req):
        if "user" in req.session.keys() and req.session['user']:
            user = req.session['user']
            user = Patient.objects.get(PatientID = user['id'])
            context = {
                "user": user,
                "error":self.error,
            }
            return render(req, 'patient/patient_profile.html', context)
        else:
            return HttpResponseRedirect('signin') 
    def post(self,req):
        self.req = req
        user = req.session['user']
        p_id = user["id"]
        patient = Patient.objects.get(PatientID = p_id)
        if self.test_verify(Patient,patient):
            for field in patient.get_fields_names()[3:]:
                value = req.POST.get(field, None)
                setattr(patient, field, value)
                patient.save()
        return HttpResponseRedirect(reverse('patient_profile'))

    def test_verify(self, model,query):
        email_field = {"old_email":"", "new_email":"","Email":""}
        for field in email_field:
            email_field[field] = self.req.POST.get(field, None)
        if "" not in email_field.values():
            if email_field["new_email"] == email_field["old_email"]:
                self.error.append("Please enter a different email")
            else:
                if email_field["Email"] != email_field["new_email"]:
                    self.error.append("Confirm email and new email does not match")
                else:
                    if model.objects.filter(Email = email_field["new_email"]):
                        self.error.append("Current email has been registered, please enter another email")
                    else:
                        query.Email = email_field["Email"]
        password_field = {"original_password":"","old_password":"", "new_password":"","Password":""}
        for field in password_field:
            password_field[field] = self.req.POST.get(field, None)
        if "" not in password_field.values():
            if password_field["old_password"] != password_field["original_password"]:
                self.error.append("Old password does not match")
            else:
                if password_field["new_password"] != password_field["Password"]:
                    self.error.append("Confirm password does not match")
                else:
                    if password_field["old_password"] == password_field["Password"]:
                        self.error.append("Please enter a different new password")
                    else:
                        query.Passowrd = password_field["Password"]
        if not self.error:    
            query.save()
            self.error = []
            return True
        else:
            return False
def PatientSearchView(req):
    if req.session['user']:
        clinic_id_list = Clinic.objects.values_list("ClinicID", flat=True)
        clinic_id_list = list(clinic_id_list)
        result = []
        for clinic_id in clinic_id_list:
            query = Clinic.objects.get(ClinicID = clinic_id)
            result.append(query)
        return render(req, 'patient/patient_search.html', context={"result":result})
    else:
        return HttpResponseRedirect('signin') 



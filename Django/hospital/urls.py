"""hospital URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls import url
from django.contrib import admin
from django.urls import include, path, re_path
from django.views.static import serve
from hospital import settings
from server import views

urlpatterns = [
    url(r'^static/(?P<path>.*)$', serve,
        {'document_root': settings.STATIC_ROOT}, name='static'),
        re_path(r'media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
    url(r'^media/(?P<path>.*)$', serve,
        {'document_root': settings.MEDIA_ROOT}, name='media'),
    path('admin/', admin.site.urls),
    path('', views.HomeView.as_view(), name="home"),
    path('home/', views.HomeView.as_view(), name="home"),
    path('presentation/', views.PresentationView.as_view(), name="presentation"),
    path('chat_box/',views.ChatbotView, name="chatbox"),
    path('signin/', views.SignInView.as_view(), name="signin"),
    path('signup/', views.SignUpView.as_view(), name="signup"),
    path('logout/', views.LogoutView.as_view(), name="logout"),
    #Clinic
    path('dashboard/', views.ClinicDashBoardView.as_view(), name="dashboard"),
    path('GetSchedule/',views.GetSchedule),
    path('clinic_search', views.ClinicSearchView, name="clinic_search"),
    # requestlist views
    path('requestlist/',views.RequestListView.as_view(),name='requestlist'),
    path('cancel_reqest/', views.cancel_reqest),# cancel a request
    path('approve_reqest/',views.approve_reqest),# approve a request
    ###
    path('upload_report/', views.UploadReportView.as_view(), name="upload_report"),
    path('statictics/',views.get_statistics, name='statistics'),
    path('clinic_profile/',views.ClinicProfileView.as_view(), name = 'clinic_profile'),
    path('time_and_question/', views.TimeAndQuestionBuild.as_view(), name = "time_and_question"),
    #Patient
    path('appointment/', views.AppointmentView.as_view(), name="appointment"),
    # appointment sub-views
    path('step1/',views.Step_1),#POST selected examination
    path('step2/',views.Step_2),#GET clinic information by clinic id
    path('step3/', views.Step_3),#GET timeslots from selected: examination, clinic, date
    path('step6/', views.Step_6),#POST insert new appointment record to database and send email
    ###
    path('patient_profile/', views.ProfileView.as_view(),name="patient_profile"),
    path('bookings/', views.PatientBookingView.as_view(), name="bookings"),
    path('patient_search', views.PatientSearchView, name="patient_search"),
 ]# + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


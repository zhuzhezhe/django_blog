#coding:utf-8
from django.http import HttpResponse
from django.shortcuts import render


# blog初始页
def home(request):
	return render(request, 'home.html')
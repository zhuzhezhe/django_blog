#coding:utf-8
from django.contrib import admin
from .models import Page, Category, Tag
# Register your models here.

admin.site.register(Page)
admin.site.register(Category)
admin.site.register(Tag)

#coding:utf-8
'''
这里是blog的urlconf配置
__author__ = 'zhuzhezhe'
'''

from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView
#from . import views
from .views import *
'''
1. 不能正确显示页面，原因是url的设置，detail和category的url匹配重复
'''
urlpatterns = patterns('',
    url(r'^$', index, name='index'),
    url(r'^(?P<pageNum>[0-9]{3})/$', index),
    url(r'^detail/(?P<title>.+)/$', detail, name='detail'),
    url(r'^archive/category/$', category, name='category'),
    url(r'^archive/category/(?P<cate_list>\w+)/$', archive_cate, name='cate_list'),
    url(r'^archive/tag/$', tag, name='tag'),
    url(r'^archive/tag/(?P<tag_list>\w+)/$', archive_tag, name='tag_list'),
    url(r'^archive/about/', about, name='about'),
    url(r'^archive/test/$', test),


)
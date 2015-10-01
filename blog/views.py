#coding:utf-8
from django.shortcuts import render, get_object_or_404
from .models import Page, Category, Tag
from django.http import Http404
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.generic import TemplateView
from django.views.generic.dates import MonthArchiveView, YearArchiveView
# Create your views here.
#这里是控制

#首页
def index(request, pageNum=1):
    sql = 'select * from blog_page order by id DESC '
    contacts = Page.objects.all()
    #分页处理
    paginator = Paginator(contacts, 8)
    #得到请求
    page = request.GET.get('page')
    try:
        contacts = paginator.page(page)
    except PageNotAnInteger:
        contacts = paginator.page(1)
    except EmptyPage:
        contacts = paginator.page(paginator.num_pages)
    contents = {'contacts': contacts}
    return render(request, 'blog/index.html', contents)

#文章详情页
def detail(request, title):
    details = Page.objects.filter(title=title)
    sql_before = 'select * from blog_page where id=(select id from blog_page where title=%s)-1'
    sql_next = 'select * from blog_page where id=(select id from blog_page where title=%s)+1'
    previous = Page.objects.raw(sql_before, title)
    nexts = Page.objects.raw(sql_next, title)
    contents = {
            'details': details,
            'title': title,
            'previous': previous,
            'nexts': nexts,
        }
    return render(request, 'blog/detail.html', contents)

#分类页
def category(request):
    categories = Category.objects.all()
    contents = {
        'categories': categories,
    }
    return render(request, 'blog/category.html', contents)

#标签页
def tag(request):
    try:
        tags = Tag.objects.all()
        contents = {
            'tags': tags,
        }
    except Tag.DoesNotExist:
        raise Http404('wrong')
    return render(request, 'blog/tag.html', contents)

def archive_cate(request, cate_list):
    try:
        cate_list = Page.objects.filter(category__name=cate_list)
        is_cate = True
    except Page.DoesNotExist:
        raise Http404
    contents = {
        "cate_list": cate_list,
        "is_cate": is_cate,
                }
    return render(request, 'blog/archive_cate.html', contents)

def archive_tag(request, tag_list):
    try:
        tag_list = Page.objects.filter(tag__name=tag_list)
    except Page.DoesNotExist:
        raise Http404
    contents = {
        "tag_list": tag_list,
                }
    return render(request, 'blog/archive_tag.html', contents)

#关于页
'''
class AboutView(TemplateView):
    template_name = 'blog/about.html'
'''
def about(request):
    return render(request, 'blog/about.html')

#实验室
def test(request):
    return render(request, 'blog/test.html')


#coding:utf-8
from django.db import models

# Create your models here.
#这里是创建数据库

#用户表
class User(models.Model):
    name = models.CharField(max_length=20)
    mail = models.EmailField()
    pwd = models.CharField(max_length=20, unique=True)

    def __unicode__(self):
        return self.name


#分类表
class Category(models.Model):
    name = models.CharField(max_length=20)

    def __unicode__(self):
        return self.name

#标签表
class Tag(models.Model):
    name = models.CharField(max_length=20)

    def __unicode__(self):
        return self.name

#文章表
class Page(models.Model):
    category = models.ForeignKey(Category)
    tag = models.ForeignKey(Tag)
    author = models.CharField(max_length=20)
    title = models.CharField(max_length=200)
    content = models.TextField()
    time = models.DateField(auto_now_add=True)
    #定义排序方式
    class Meta:
        ordering = ('-time', )

    def __unicode__(self):
        return self.title
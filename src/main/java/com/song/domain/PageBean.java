package com.song.domain;


import java.util.List;

/**
 * 自定义分页组件实体
 * @param <T>
 */
public class PageBean<T> {

    private Integer totalCount ; //总记录数
    private Integer totalPage; //总页数
    private Integer currentPage ;//当前页码
    private Integer pageSize ;//每页显示条数
    private List<T> list ;//当前页面中的集合数据

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Integer getTotalPage() {
//        return totalPage;
        return  (int)Math.ceil((totalCount*1.0/pageSize)); //总页数
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }


    public PageBean() {
    }


    public PageBean(Integer totalCount, Integer currentPage, Integer pageSize, List<T> list) {
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.list = list;
    }
}

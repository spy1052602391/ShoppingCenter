package com.song.dao;

import com.song.domain.Category;

import java.util.List;

public interface CategoryMapper {

    public List<Category> findAll() throws Exception;

}

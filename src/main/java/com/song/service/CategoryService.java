package com.song.service;

import com.song.domain.Category;

import java.util.List;

public interface CategoryService {

    List<Category> findAll() throws  Exception;

}

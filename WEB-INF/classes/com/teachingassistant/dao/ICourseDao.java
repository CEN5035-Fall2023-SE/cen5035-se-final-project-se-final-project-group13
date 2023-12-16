package com.teachingassistant.dao;

import java.util.List;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.ProfessorDetails;

public interface ICourseDao {

	public void addCourse(String courseId, String courseName, String professorId, String openPositions) throws Exception;

	public List<CourseDetails> updateOrDeleteCourse(String actionType,String courseId,String openPositions) throws Exception;

	public List<CourseDetails> loadCourseDetails() throws Exception;

	public CourseDetails getProfessorDetailsByCourseId(String courseId) throws Exception;

}

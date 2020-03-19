package com.kh.portfolio.board.vo;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ImageBoardVO {
	
	private int imageNum;
	private String imageTitle;
	private String imageId;
	private String imageDesc;
	private String imageUrl;
	private int imageHit;
	private Timestamp imageCdate;
	private List<MultipartFile> files;

}

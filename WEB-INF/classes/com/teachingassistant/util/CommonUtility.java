package com.teachingassistant.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class CommonUtility {

	public static void convertWordFileToPdf(String userId, String fileName) {
		InputStream docxInputStream = null;
		XWPFDocument document = null;
		OutputStream pdfOutputStream = null;
		Document pdfDocument = null;
		try {
			String inputFile = DBUtil.properties.getProperty("file.path") + File.separator + userId + "_" + fileName;
			docxInputStream = new FileInputStream(inputFile);
			document = new XWPFDocument(docxInputStream);

			fileName = fileName.replace(".docx", ".pdf").replace(".doc", ".pdf");

			String outputFile = DBUtil.properties.getProperty("file.path") + File.separator + userId + "_" + fileName;

			pdfOutputStream = new FileOutputStream(outputFile);
			pdfDocument = new Document();
			PdfWriter.getInstance(pdfDocument, pdfOutputStream);
			pdfDocument.open();

			List<XWPFParagraph> paragraphs = document.getParagraphs();
			for (XWPFParagraph paragraph : paragraphs) {
				pdfDocument.add(new Paragraph(paragraph.getText()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pdfDocument != null) {
					pdfDocument.close();
				}
				if (pdfOutputStream != null) {
					pdfOutputStream.close();
				}
				if (document != null) {
					document.close();
				}
				if (docxInputStream != null) {
					docxInputStream.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
	}
}

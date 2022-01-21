package com.groupware.worktech.commut.model.vo;

public class QRCode {
	
	private int q_no;
	private String file_name;
	private String file_path;
	private String m_no;
	private String q_status;

	public QRCode() {}
	
	

	

	public QRCode(int q_no, String file_name, String file_path, String m_no, String q_status) {
		super();
		this.q_no = q_no;
		this.file_name = file_name;
		this.file_path = file_path;
		this.m_no = m_no;
		this.q_status = q_status;
	}





	public QRCode(int q_no, String file_name, String file_path, String m_no) {
		super();
		this.q_no = q_no;
		this.file_name = file_name;
		this.file_path = file_path;
		this.m_no = m_no;
	}

	
	
  
	public String getQ_status() {
		return q_status;
	}





	public void setQ_status(String q_status) {
		this.q_status = q_status;
	}





	public int getQ_no() {
		return q_no;
	}



	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}



	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public String getM_no() {
		return m_no;
	}

	public void setM_no(String m_no) {
		this.m_no = m_no;
	}

	@Override
	public String toString() {
		return "QRCode [file_name=" + file_name + ", file_path=" + file_path + ", m_no=" + m_no + "]";
	}
	
	
}

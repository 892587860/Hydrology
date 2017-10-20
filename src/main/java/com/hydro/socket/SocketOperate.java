package com.hydro.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;

import com.hydro.util.TimingPacketParseUtil;

public class SocketOperate implements Runnable {
	
	public static final String CHARCODE = "utf-8";
	
	private Socket socket;
	
	// 该线程所处理的Socket所对应的输入流
	BufferedReader reader = null;
	
    PrintWriter writer = null;
    
	String str = null;
	String content = null;

	public SocketOperate(Socket socket) throws IOException {
		this.socket = socket;
		
		reader = getReader(this.socket);
		
		writer = getWriter(this.socket);
	}
	
	private PrintWriter getWriter(Socket socket) throws IOException {
		OutputStream outputStream = socket.getOutputStream();
		return new PrintWriter(new OutputStreamWriter(outputStream, CHARCODE), true);
	}

	private BufferedReader getReader(Socket socket) throws IOException {
		InputStream inputStream = socket.getInputStream();
		return new BufferedReader(new InputStreamReader(inputStream, CHARCODE));
	}

	@Override
	public void run() {
		// 采用循环不断从Socket中读取客户端发送过来的数据
		while (true) {
			content = readFromClient();
			if (content == null) {
				break;
			}
			System.out.println("-----服务器接受的报文为："+content);
			if(TimingPacketParseUtil.parseUpPacket(content)){
				writer.println("--------报文传输有误-------------");
			}
			writer.println("-----------服务端成功获取客户端数据");
		}
	}

	// 定义读取客户端数据的方法
	private String readFromClient() {
		try {
			str = reader.readLine();
			return str;
		}
		// 如果捕捉到异常，表明该Socket对应的客户端已经关闭
		catch (IOException e) {
			try {
				reader.close();
				socket.close();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return null;
	}
}
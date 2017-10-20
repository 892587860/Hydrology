package com.hydro.socket.thread;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

import com.hydro.socket.SocketOperate;

public class ServerThread extends Thread {
	private ServerSocket serverSocket = null;

	public ServerThread(ServerSocket serverScoket) {
		try {
			if (null == serverSocket) {
				this.serverSocket = new ServerSocket(1200);
				System.out.println("----------------socket start-------------");
			}
		} catch (Exception e) {
			System.out.println("------------------ServerThread创建socket服务出错----------------");
			e.printStackTrace();
		}
	}

	public void run() {
		while (true) {
			try {
				if (serverSocket == null) {
					break;
				} else if (serverSocket.isClosed()) {
					break;
				}
				Socket socket = serverSocket.accept();
				if (null != socket && !socket.isClosed()) {
					// 处理接受的数据
					Thread t = new Thread(new SocketOperate(socket));
					t.start();
				} else {
					break;
				}
			} catch (Exception e) {
				System.out.println("ServerThread创建socket服务出错");
				e.printStackTrace();
			}
		}
	}

	public void closeSocketServer() {
		try {
			if (null != serverSocket && !serverSocket.isClosed()) {
				serverSocket.close();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
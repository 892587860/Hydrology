package com.hydro.socket.listener;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.hydro.socket.thread.ServerThread;

public class ServerSocketListener implements ServletContextListener {
	private ServerThread serverThread;

	public void contextDestroyed(ServletContextEvent arg) {
		if (null != serverThread && !serverThread.isInterrupted()) {
			serverThread.closeSocketServer();
			serverThread.interrupt();
		}
	}

	@Override
	public void contextInitialized(ServletContextEvent arg) {
		if (null == serverThread) {
			// 新建线程类
			serverThread = new ServerThread(null);
			// 启动线程
			serverThread.start();
		}
	}
}

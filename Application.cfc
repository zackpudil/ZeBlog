component extends="org.corfield.framework" {
		this.name = "zeblog";
		this.ormenabled = true;
		this.datasource = "blog";
		this.ormsettings.cfclocation = "models";
		this.ormsettings.dialect = "Derby";
		this.sessionmanagement = true;
		this.scriptprotect="all";
		
		variables.framework = {
			unhandledPaths = '/ZeBlog/includes'
		};

		public boolean function setupRequest(targetPage) {
			ormReload();
			ormFlush();
			writeLog(text="Started Request", file=this.name);
			return true;
		}

		public void function setupSession() {
			session.logged_in = false;
			session.isAdmin = false;
			session.style = "brown";
			writeLog(text="Started new session", file=this.name);
		}
}

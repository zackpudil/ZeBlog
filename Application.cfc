component extends="org.corfield.framework" {
				this.name = "zeblog";
				this.ormenabled = true;
				this.datasource = "blog";
				this.ormsettings.cfclocation = "models";
				this.ormsettings.dialect = "Derby";
				this.sessionmanagement = true;
				this.scriptprotect="all";

				public boolean function setupRequest(targetPage) {
								ormReload();
								ormFlush();
								return true;
				}

				public void function setupSession() {
								session.logged_in = false;
								session.isAdmin = false;
								session.style = "greenbase.css";
				}
}

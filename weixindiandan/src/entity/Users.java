package entity;

public class Users {
	private String weichatId = "";
	private String vipExpiryDate = "";
	private int shellEdOut = 0;
	private String shopId = "";

	public String getWeichatId() {
		return weichatId;
	}

	public void setWeichatId(String weichatId) {
		this.weichatId = weichatId;
	}

	public String getVipExpiryDate() {
		return vipExpiryDate;
	}

	public void setVipExpiryDate(String vipExpiryDate) {
		this.vipExpiryDate = vipExpiryDate;
	}

	public int getShellEdOut() {
		return shellEdOut;
	}

	public void setShellEdOut(int shellEdOut) {
		this.shellEdOut = shellEdOut;
	}

	public String getShopId() {
		return shopId;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

}

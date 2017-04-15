package entity;

public class Prices {
	private String shopId = "";
	private String itemId = "";
	private Float price = null;
	private Float vipPrice = null;
	private String sign = "";
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getShopId() {
		return shopId;
	}
	public float getVipPrice() {
		return vipPrice;
	}
	public void setVipPrice(Float vipPrice) {
		this.vipPrice = vipPrice;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
}

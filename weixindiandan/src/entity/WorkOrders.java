package entity;

public class WorkOrders {
	private String orderId = null;
	private String shopId = null;
	private String itemIds = null;
	private String price = null;
	private Boolean ifBalance = null;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public String getItemIds() {
		return itemIds;
	}
	public void setItemIds(String itemIds) {
		this.itemIds = itemIds;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public Boolean getIfBalance() {
		return ifBalance;
	}
	public void setIfBalance(Boolean ifBalance) {
		this.ifBalance = ifBalance;
	}
}

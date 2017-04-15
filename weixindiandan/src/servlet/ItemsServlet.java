package servlet;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RonaCoffeeMenu;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class ItemsServlet
 */
@WebServlet("/ItemsServlet")
public class ItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setHeader("Access-Control-Allow-Origin", "*");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		RonaCoffeeMenu rona = new RonaCoffeeMenu(request,response);
		JSONObject json = JSONObject.fromString(request.getParameter("message"));
		System.out.println(json);
		
		String res = "error";
		switch(json.getString("type")){
			case "getAllItemsByShopId":
				//�����̵�ID��ȡ�̵���item�����λ
				System.out.println(json.getString("shopId"));
				res = rona.getPricesByShopId(json.getString("shopId")).toString();
				Writer writer = response.getWriter();
				writer.write(res);
			break;
			case "getUpload"://����û��ĵ��
				//�����̵�ID��ȡ�̵���item�����λ
				System.out.println(json.getString("shopId"));
			break;
		}
	}
}

package servlet;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import dao.ItemDAO;
import dto.ItemDTO;

@WebServlet("/AddItemServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   
    maxFileSize = 1024 * 1024 * 10,   
    maxRequestSize = 1024 * 1024 * 50   
)
public class AddItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

 
        List<String> photoFileNames = new ArrayList<>();

        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            if ((part.getName().equals("photo") || part.getName().equals("photo[]")) && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                if (fileName != null && !fileName.isEmpty()) {
                    String saveName = System.currentTimeMillis() + "_" + fileName;
                    part.write(uploadPath + File.separator + saveName);
                    photoFileNames.add(saveName); 
                }
            }
        }

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String status = request.getParameter("status");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String sellerId = request.getParameter("sellerId");
        String sellerName = request.getParameter("sellerName");
        String professor = request.getParameter("professor");
        String yearStr = request.getParameter("year");
        String department = request.getParameter("department");
        String itemType = request.getParameter("itemType");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");

        int price = 0;
        int year = 0;
        try { price = Integer.parseInt(priceStr); } catch (Exception e) {}
        try { year = Integer.parseInt(yearStr); } catch (Exception e) {}

        ItemDTO item = new ItemDTO();
        item.setTitle(title);
        item.setAuthor(author);
        item.setPublisher(publisher);
        item.setStatus(status);
        item.setPrice(price);
        item.setDescription(description);
        item.setBrand(brand);
        item.setModel(model);

   
        String photoFilesStr = String.join(",", photoFileNames);
        item.setPhoto(photoFilesStr);

        item.setSellerId(sellerId);
        item.setSellerName(sellerName);
        item.setProfessor(professor);
        item.setYear(year);
        item.setDepartment(department);
        item.setItemType(itemType);

        ItemDAO dao = new ItemDAO();
        int result = dao.insertItem(item);

        if (result > 0) {
            response.sendRedirect("main.jsp");
        } else {
            response.sendRedirect("item_detail.jsp?error=1");
        }
    }
}

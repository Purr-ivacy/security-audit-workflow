# Internal API Reference
**Authentication:**  
- Use `Authorization: Bearer <token>` header.  
- Tokens are rotated weekly.  

**Endpoints:**  
- `GET /user/me` → Returns current user profile.  
- `POST /audit/log` → Submit a security log.  

> **Warning:** Never commit tokens to version control!  
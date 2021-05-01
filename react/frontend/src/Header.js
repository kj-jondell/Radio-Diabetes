import "./Header.css";

import { Link } from "react-router-dom";

const HeaderLink = ({ page }) => {
  const title = page.charAt(0).toUpperCase() + page.slice(1);
  return (
    <Link to={`/${page}`} className="headerlink-title">
      {title}
    </Link>
  );
};

const Header = () => {
  return (
    <div className="header">
      <div className="nav-container">
        <HeaderLink page="om"></HeaderLink>
        {/*<HeaderLink page="uppladdning"></HeaderLink>*/}
        <HeaderLink page="uppladdning"></HeaderLink>
        {/*<HeaderLink page="kontakt"></HeaderLink>*/}
      </div>
    </div>
  );
};

export default Header;

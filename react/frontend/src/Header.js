import { Link, useParams } from 'react-router-dom';
import './Header.css';

const HeaderLink = ({ page }) => {
    const title = page.charAt(0).toUpperCase() + page.slice(1);
    return <Link to={`/${page}`} className='headerlink-title'>{title}</Link>
};

const Header = () => {
    return (
        <div className='header'>
            <HeaderLink page='hem'></HeaderLink>
            <HeaderLink page='om'></HeaderLink>
            <HeaderLink page='lyssna'></HeaderLink>
            <HeaderLink page='uppladdning'></HeaderLink>
        </div>
    )
};

export default Header;